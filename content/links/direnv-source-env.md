---
tags: link
layout: layouts/link.liquid
title: Direnv's `source_env`, and how to manage project configuration
author: "brandur.org"
externalLink: "https://brandur.org/fragments/direnv-source-env"
date: "git Created"
---

> Well, after being a Direnv user for ten years, yesterday I learnt of the existence of source_env, a special directive that can go in an .envrc and which will read out out of another envrc file.
>
> This simplifies the configuration of my projects dramatically. They have an .envrc.sample, but it’s stripped down to almost nothing, containing only a source_env statement and room to add customization.
