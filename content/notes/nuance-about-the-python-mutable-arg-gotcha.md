---
tags: note
layout: layouts/note.liquid
title: nuance about the Python mutable arg gotcha
date: "git Created"
---

I hit a gotcha today when writing a Python function.  I wanted to add some nuance to document Python's odd behavior.  The gotcha, from the [Ruff docs](https://docs.astral.sh/ruff/rules/mutable-argument-default):

> The same mutable object is then shared across all calls to the function. If the object is modified, those modifications will persist across calls, which can lead to unexpected behavior.
>
> Instead, prefer to use immutable data structures, or take None as a default, and initialize a new mutable object inside the function body for each call.

(cf. the [_Hitchhiker's Guide to Python_](https://docs.python-guide.org/writing/gotchas/#mutable-default-arguments).)

The examples in both of those page are helpful, but I wanted to lay out the difference between a default mutabled argument that is actually mutated, and one that is not.  The bottom line: if you don't mutate the argument, you won't get the unexpected, gotcha behavior.

```python
In [28]: def does_mutate(alist=[]):
    ...:     alist.append(random.randint(1, 10))
    ...:     print(alist)
    
In [29]: does_mutate()
[6]

In [30]: does_mutate()
[6, 10]

# passing in a new list does not use the original instance
In [31]: does_mutate([1, 2, 3])
[1, 2, 3, 8]

# relying on the default _does_ use the original default instance, now modified, plus any changes when that default is used
In [32]: does_mutate()
[6, 10, 4]

In [33]: def doesnt_mutate(alist=[]):
    ...:     print(alist)
    
In [34]: doesnt_mutate()
[]

In [35]: doesnt_mutate([1, 2, 3, 4, 5, 6, 7])
[1, 2, 3, 4, 5, 6, 7]

In [36]: doesnt_mutate([1, 2, 3])
[1, 2, 3]

# Relies on the default, as would be intuitive—no gotchas
In [37]: doesnt_mutate()
[]
```
