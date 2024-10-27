---
tags: note
layout: layouts/note.liquid
title: deploying to fly.io
date: "git Created"
---

The [getting started with Django on Fly.io guide](https://fly.io/docs/django/getting-started/) is nice, and generally things worked smoothly.  I'll add a few things for using Postgres:

Install the Postgres packages that you need:

```python
dj-database-url
django-environ
psycopg[binary,pool]
```

And modify your settings file:

```python
env = environ.Env()
env_file = os.path.join(BASE_DIR, ".env")

if os.path.exists(env_file):
    environ.Env.read_env(env_file)

FLY_ENV = False
if env.str("FLY_APP_NAME", None):
    FLY_ENV = True
    FLY_APP_NAME = os.environ.get("FLY_APP_NAME")

if FLY_ENV:
    DATABASES = {
        "default": dj_database_url.config(conn_max_age=600, ssl_require=True)
    }
    DEBUG = False
    SECRET_KEY = env.str("SECRET_KEY")
    ALLOWED_HOSTS = [f"{FLY_APP_NAME}.fly.dev"]
```

And don't miss [these instructions](https://fly.io/docs/postgres/getting-started/what-you-should-know/) on managing your PG instance:

> This is not a managed database. If Postgres crashes because it ran out of memory or disk space, you’ll need to do a little work to get it back.
