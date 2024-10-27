---
tags: note
layout: layouts/note.liquid
title: creating a simple Django app
date: "git Created"
---

Next step for my [cookiecutter template]({{'/content/notes/i-made-a-cookiecutter.md/' | url }}) is to create a basic app, and a landing page.  

(Full commit for the code in this note is [here](https://github.com/briandant/cookiecutter-dj-thedude/commit/4927fc2d8049eeff2462a4e40af4d82f8f04f33a).)

```sh
.venv/bin/python manage.py startapp base
```

That gives us the basic layout of a Django app:

```sh
(.venv) ┌─[briandant@beebop] - [~/personal/cookiecutter-dj-thedude/cookies] - [2024-10-27 03:44:47]
└─[0] <git:(main 5e78c87) > ls -1 base
__init__.py
admin.py
apps.py
migrations
models.py
tests.py
views.py
```

As a cookiecutter template, we're going to need some fancy landing page.

Let's add a template view in `base.urls`:

```python
urlpatterns = [
    path("", TemplateView.as_view(template_name="base/index.html")),
]
```

The template naming approach I'm using there makes it easy to find templates.  In each app, I create an `appname/templates/appname` directory.  This way, each template is prefixed with `appname`, so in a template, it's clear where it lives:

```liquid
{%- raw %}
{% include base/index.html %}
{% endraw %}
```

And if you create this `templates/` dir in each app, and leave the basic template config alone, it will just work.  There's a bit of redundency in the directory structure, but I've found that's it's worth the tradeoff, for the simplicity and for the transparency in template `extends` and `includes`.

Alright, we've got a basic landing page:

![Landing Page](/images/basic-landing-page.png)
