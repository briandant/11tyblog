---
tags: note
layout: layouts/note.liquid
title: adding users to django
date: "git Created"
---

Still [working towards creating a cookiecutter template]({{'/content/notes/i-made-a-cookiecutter.md/' | url }}).  I'm enjoying the aspect of refreshing my fundamental Django knowledge.  E.g., I create a users app like once every five years at work.  I'll add that today.

## bottom line, up front

Over the years, Django's had to wrestle to get a simple user app setup.  After working through this for the first time in a while, it's now quite simple, for the basic stuff.

...

First, we'll start simple.  The goal is to enable the simplest possible user setup in Django, and if the need arises, I'll add social auth and all that.  Real Python has a basic guide for [setting up users](https://realpython.com/django-user-management/).  Let's start there.

Actually, let's start with [the docs](https://docs.djangoproject.com/en/5.1/topics/auth/default/#using-the-views).  Basically, Django has a set of views that one can user, and a user model with the basic stuff.  It's pretty much everything you need to get started, and you can extend or grab a different user/auth/permissions app, as needed.  I'm gonna list out what I want for this first step of the cookiecutter:

- Create a user from the UI (Django admin is okay for now)
- Enable the password workflow

"Everything you need," is what we get out of the box:

```sh
accounts/login/ [name='login']
accounts/logout/ [name='logout']
accounts/password_change/ [name='password_change']
accounts/password_change/done/ [name='password_change_done']
accounts/password_reset/ [name='password_reset']
accounts/password_reset/done/ [name='password_reset_done']
accounts/reset/<uidb64>/<token>/ [name='password_reset_confirm']
accounts/reset/done/ [name='password_reset_complete']
```

A user can login, out, and change password. And I can create new users from the admin.  No registration, no social auth, but that's for later.  I get that all by adding this to my `urls.py` (and, of course, enabling the admin, where I create users):

```python
urlpatterns = [
    path("accounts/", include("django.contrib.auth.urls")),
]
```

Okay, there it is.  I can create a user, who can login, out, and change password.
