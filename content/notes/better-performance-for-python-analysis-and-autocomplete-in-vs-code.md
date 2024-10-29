---
tags: note
layout: layouts/note.liquid
title: better performance for python analysis and autocomplete in vs code
date: "git Created"
---

I've been frustrated with VS Code's inability to find classes for autocompleting; i.e., when I'm writing:

```python
def myfunc():
    aninstance = MoneyBusinessFactory()
```

When I type `MonkeyBusinessF`, I want VS Code to offer autocomplete options, and it should include all the class in my project, without requiring me to add extra config.  I couldn't get it to work for a long time, and I ended up using:

```json
"python.autoComplete.extraPaths": [
    'path/to/app',
    'path/to/another/app',
],
"python.analysis.extraPaths": [
    'path/to/app',
    'path/to/anotherapp'
]
```

That's the "extra config."  This is obviously terribly annoying an ineffective.  When a team member adds a new app, I have to add it to my Workspace settings.  

I learned that you can instead add `PYTHONPATH=/my/workspace/root` to a `.env`, and then add this to your workspace settings:

```sh
"python.envFile": "${workspaceFolder}/.env"
```

It seems to be working exactly as expected, out of the box.  But, if I have a `.env` in one of the workspace folders, and I want to use the vars from it in, e.g., at VS Code task, I've now lost that, and the project in that folder wants the `.env` to be in that folder.  We'll see how that part works out ...
