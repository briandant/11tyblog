---
tags: note
layout: layouts/note.liquid
title: fix vs code test discovery in a nix env
date: "git Created"
---

In VS Code, I'm using the [integrated Django test runner](https://code.visualstudio.com/docs/python/testing#_django-unit-tests), which was released last month.  So far, it's nice.

I then started using a [plugin for direnv](https://marketplace.visualstudio.com/items?itemName=mkhl.direnv).  I wanted to use that so that I could write VS Code tasks in my nix flakes environment.  But when I started using the direnv plugin, I got this error during test discovery:

```sh
pvsc_utils.VSCodeUnittestError: DJANGO ERROR: An error occurred while discovering and building the test suite. Error: Error attempting to connect to extension named pipe /var/folders/l3/tn48czyn38nfr8dqkfbyf8_40000gn/T/nix-shell.TutI0O/python-test-discovery-9b761bb58dc888e589f8.sock[vscode-unittest]: AF_UNIX path too long
```

The Python extension, apparently, was creating it's sockets nested in the nix env.  

To fix this, I set this in my `.env`:

```sh
TMPDIR=/tmp
```

And the test discovery process worked again.  We'll see if it holds up ...
