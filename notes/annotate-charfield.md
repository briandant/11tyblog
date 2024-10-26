# annotating a django queryset with a charfield

Say that I'm putting together an inventory of my daughter's lost snacks.  And I want to see all the Skittles that are in the couch cushions.  That would never happen in my house, but ya know.  

Let's also say that we have the constraint of using Django Filters, rather than doing something in a template.  

I have a model:

```python
from django.db import models

class Locations(models.Model):
    name = models.CharField(
        max_length=255, choices=["cabinet", "couch", "under-bed"]
    )

class Skittles(models.Model):
    color = models.CharField(max_length=255)

class SkittleLocation(models.Model):
    skittle = models.ForeignKey(Skittles, on_delete=models.CASCADE)
    location = models.ForeignKey(Locations, on_delete=models.CASCADE)
```



And I want to display all of them in the filter view, but I want the dropdown to show `red - couch`.  

Django filters doesn't have a convenient way to dynamically build the choices, other than a custom `ChoiceFilter`, from what I can see.  And once we do all that, we'll just be putting a query into some `get_choice` method or whatever.  So I thought it would be easier to just add an annotated field and return a `values_list`:

```python
from django.db import models
from django.db.models import Value
from django.db.models.functions import Concat

class SnacksFilter(django_filters.FilterSet):
    ...
    skittles = django_filters.ChoiceFilter(
    choices=
        SkittleLocation.objects.all()
            .order_by("color")
            .annotate(
            display=Concat(
                models.F("skittle__color"),
                Value("-"),
                models.F("location__name"),
                output_field=models.CharField(),
            ),
        )
    .values_list("id", "display")
    )
    ,
    ...
```

With some help from: <https://stackoverflow.com/a/50682754>.
