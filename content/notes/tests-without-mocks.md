---
tags: note
layout: layouts/note.liquid
title: tests without mocks
date: "git Created"
---

I've been slowly reading through James Shore's "[Testing Without Mocks: A Pattern Language"](https://www.jamesshore.com/v2/projects/nullables/testing-without-mocks)", and implementing it in my tests.  So far, I like the approach, and find that it helps to ensure that my functions and methods are clean, among other things.

One example came up recently.  I have a class that process new `Skittles`, and then updates the `Inventory`.  The `InventoryService`, though, requires a bunch of records in the database, unrelated to the work in the `SkittlesService`.

To get around that, I was mocking the `InventoryService.update_inventory` method to avoid creating all those excess stubs.

But we can get around that by pulling out the main work of `process()` into a `_process()` method, and then only one test needs to stub out the other stuff.

```python
class SkittlesService:
    def _process_candy(self, item: SkittleData) -> SkittleModel:
        self._read_color(item)
        self._check_size(item)

        return item

    def process(self, item: Skittle) -> None:
        item = self._process()
        if item.color and self._size_is_acceptable(item.size):
            CandyInventoryService().update_inventory()
        
        return item

class CandyInventoryService:
    ...
    def update_inventory(self, item: Candy) -> None:
        self.check_existing_inventory(item)
        self.find_available_location(item)
        inventory = self.place_in_location(item)

        return inventory
