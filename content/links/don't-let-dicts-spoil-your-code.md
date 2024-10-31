---
tags: link
layout: layouts/link.liquid
title: Don't let dicts spoil your code
author: Roman Imankulov
externalLink: https://roman.pt/posts/dont-let-dicts-spoil-your-code/
date: "git Created"
---

A clear explanation on the importance of using Domain Models, via `dataclass`, Pydantic models, or `TypeDict`, to avoid using dictionaries, which are opaque and mutable.

> On top of semantic clarity, domain models provide a natural layer that decouples the exterior architecture from your application’s business logic.

Outside formal Domain Driven Design, the principle could be stated simply as "default to using bespoke classes when passing around data in your application."
