---
tags: note
layout: layouts/note.liquid
title: adding Tailwind to the cookiecutter template
date: "git Created"
---

Next step for my [cookiecutter template]({{'/content/notes/i-made-a-cookiecutter.md/' | url }}) is to add Tailwind, and create a fancier landing page.  I've still got to work out how I'll manage static assets for production deployments—and that should probably happen before I create the static assets—but here we are.  I want a fancy page.

(Full commit for this note: <https://github.com/briandant/cookiecutter-dj-thedude/commit/c1aeb5ef1a615573784f097cfad97a251fd98fd2>)

The things to do:

- Add Tailwind packages
- Create the Tailwind config file
- Create the Tailwind input css
- Decide on the static asset structure for the Django app

Let's follow the Tailwind doc's Getting Started: <https://tailwindcss.com/docs/installation>.

I've already got `node` in my `flake.nix`, so I should be able to roll right away with:

```sh
npm install tailwindcss
npx tailwindcss init
```

But first I need to `npm init`.

The interesting part of all this is determining the Django structure.  With Tailwind, this is simple—since we won't have a ton of `.css` files, we can drop them into a `static` directory in the Django app.  I suppose I should take a minute to look at the Django defaults for static files.

So a few things are not set:

```python
In [1]: from django.conf import settings

In [2]: settings.STATIC_ROOT

In [3]: settings.STATIC_URL
Out[3]: '/static/'

In [4]: settings.STATICFILES_DIRS
Out[4]: []

In [5]: settings.STATICFILES_FINDERS
Out[5]: 
['django.contrib.staticfiles.finders.FileSystemFinder',
 'django.contrib.staticfiles.finders.AppDirectoriesFinder']
```

`STATIC_ROOT` (<https://docs.djangoproject.com/en/5.1/ref/settings/#static-root>):

> The absolute path to the directory where collectstatic will collect static files for deployment.

`STATICFILES_DIRS` (<https://docs.djangoproject.com/en/5.1/ref/settings/#std-setting-STATICFILES_DIRS>):

> This setting defines the additional locations the staticfiles app will traverse if the FileSystemFinder finder is enabled, e.g. if you use the collectstatic or findstatic management command or use the static file serving view.

`STATICFILES_FINDERS` (<https://docs.djangoproject.com/en/5.1/ref/settings/#staticfiles-finders>):

> The list of finder backends that know how to find static files in various locations.
>
> The default will find files stored in the STATICFILES_DIRS setting (using django.contrib.staticfiles.finders.FileSystemFinder) and in a static subdirectory of each app (using django.contrib.staticfiles.finders.AppDirectoriesFinder). If multiple files with the same name are present, the first file that is found will be used.

`STATIC_URL` (<https://docs.djangoproject.com/en/5.1/ref/settings/#static-url>):

> URL to use when referring to static files located in STATIC_ROOT.

For local dev, I will set:

- `STATIC_URL`: `/static`
- `STATIC_ROOT`: `/staticfiles/`
- `STATICFILES_DIR`: `/static/`

Basically, that's saying "when serving static files, use `/static`, and when looking for static files to build, look in the `static/` directory of each app, and build them into `/staticfiles`.

That's all in keeping with the vibe of this cookiecutter: simple, simple, simple.

It looks like this:

```python

STATIC_URL = "static/"

STATICFILES_DIRS: list[str] = [
    os.path.join(BASE_DIR, "static"),
]

STATICFILES_FINDERS: list[str] = [
    "django.contrib.staticfiles.finders.FileSystemFinder",
    "django.contrib.staticfiles.finders.AppDirectoriesFinder",
]

STATIC_ROOT = os.path.join(BASE_DIR, "staticfiles")
```

Now, back to the Tailwind quickstart:

```sh
npx tailwindcss -i ./src/input.css -o ./src/output.css --watch
```

We need to tell Tailwind which files to watch:

```javascript
/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    './**/templates/**/*.html'
  ],
  theme: {
    extend: {},
  },
  plugins: [],
}
```

With the output file generated, we can add `output.css` to our `base.html` Django template:

```html
{%- raw %}
<link rel="stylesheet" href="{% static 'output.css' %}" />
{% endraw %}
```

That worked.  There's nothing new to deploy, since I have to set up staticfile serving next, so that `output.css` will actually be available to the browser.

References:

<https://docs.djangoproject.com/en/5.1/howto/static-files/>
