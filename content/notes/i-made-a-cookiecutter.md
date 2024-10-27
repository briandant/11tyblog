---
tags: note
layout: layouts/note.liquid
title: i made a cookiecutter
---

EDIT: I'm *making* a cookiecutter.  It's working, but that's about it. <https://github.com/briandant/cookiecutter-dj-thedude>

I've been wanting to make a cookiecutter for a while.  I often think, *it would be cool to try X in a little Django project*, but then I don't do it, because I have to find the Makefile I like, and the nix flakes file, and then I have to move all the directories around to avoid the three layers of nesting that Django does.  And all that.

It's lazy, I know.

So, let's make `cookiecutter-dj-thedude`.  Lemme brainstorm what I want:

- [x] My standard Makefile
- [x] Nix Flakes
- [x] A simple project structure, without all that Django nesting
- [x] `.venv/` in the project rooot, rather than hidden away somewhere
- [ ] Tailwind
- [ ] htmx
- [x] Deployed to Fly.io
- [ ] Basic user management
- [ ] A basic Django app where I can start throwing stuff in right away
- [ ] Sentry
- [ ] GitHub Actions to deploy

At askflux.ai, we've been working on small vertical slices for development: create the smallest possible thing—including each level of the stack—and from there, move horizontally to build out the feature.

The complete stack, in this case, would include UI -> infrastructure, including monitoring.  So I'll start by creating a Django app, and then deploying it.  After that, I'll add an app, with a UI, then deploy it again to confirm it's all good.  Then I'll go on to enhancing things.  (We'll say that "monitoring" in this case is taken care of, by Fly.io)

So, I create the cookiecutter directory, and then copy in the Makefile, `flake.nix`, and clean them up a bit.  

I then created an app on Fly.io.  Fly is like Heroku, but with even less thinking required.  I get a Postgres instance, VM space for my app, and a bucket for media.  It took like 19 seconds, apart from fumbling with my credit card.

So, I've got a Fly app.  Let's see if I can deploy it.  Following these instructions: <https://fly.io/docs/django/getting-started/>

Well, I guess Fly got me in a wider release slice than is necessary.  I'm adding Postgres and an s3 bucket already.  

Yeah, this is turning into a "how to Fly.io" session, more than a cookiecutter session.  Notes on that [here]({{'/content/notes/deploying-to-fly.io/' | url }}).
