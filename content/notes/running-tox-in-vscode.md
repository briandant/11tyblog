---
tags: note
layout: layouts/note.liquid
title: running make and tox targets in VS Code, under nix
date: "git Created"
---

I've been a bit skiddish about running processes in the VS Code terminal.  Generally, the VS Code default mode does too much: auto-loading the venv, grabbing env vars from `.env`, and so on.  And I find myself with excess terminals that I forget to clean up well.

For example, there was an env var being set each time a new terminal was opened, and I couldn't easily understand why.  I never really figured it out.  I'd kill VS Code, and the next instance would have the env var there.  I'm sure I could figure out why with some work, but I just defaulted to running things in iTerm, for the most part.

But I want to give it more effort.  Today, I'm now trying to run my `make` and `tox` targets in VS Code.  This way I can simply open the tasks pallete, run the task, and get on with my work while, e.g., the test suite runs.  Simple VS Code tasks to do this:

```json
{
    // See https://go.microsoft.com/fwlink/?LinkId=733558
    // for the documentation about the tasks.json format
    "version": "2.0.0",
    "tasks": [
        {
            "label": "tox -e py3",
            "type": "shell",
            "command": "nix develop --command sh -c tox -e py3",
        },
        {
            "label": "make",
            "type": "shell",
            "command": "nix develop --command sh -c make",
        }
    ]
}
```

We use `nix flakes`, but I wasn't sure about setting the nix environment before the task runs.  I think there's a plugin, but I didn't want to mess with it.  Though, having all shells default to a nix-shell would be good, and maybe there's a way to do that, and stop flakes from doing all its setup before each task.
