---
tags: note
layout: layouts/note.liquid
title: workflow for small CLs
date: "git Created"
---

Make some changes.  This might be on the current branch, or on a long-running branch, from which I will cherry-pick.

Make commits along the way, to indicate what I'm doing.  These will all be wiped away in a later rebase, or soft reset, but it's good to have an indication of what's changed.

## a few background thoughts

*The perfect commit.* For commit best practices, I try to follow <https://simonwillison.net/2022/Oct/29/the-perfect-commit/>.  The "perfect commit" contains:

- The implementation: a single, focused change
- Tests that demonstrate the implementation works
- Updated documentation reflecting the change
- A link to an issue thread providing further context

*Self-contained.* A commit should be self-contained.  If someone were to reset the branch to that commit, all the tests would pass, and the code would be properly formatted.  It's easy to forget this when doing a PR-style flow.  But a repo is a set of commits, not a set of PRs (which is a group of commits).  

*Meant for use by other engineers.* A commit is something that other engineers can use to understand the codebase.  If I'm not on the clock, another engineer should be able to simply open `git blame`, view my commit, understand what I did, and why (with a link to a ticket).  Though I don't find this to be common—many engineers don't read commits—git is an amazing way to communicate, if done right.  

## the soft-reset path

If I'm on a branch that I want to break up into a few commits, I will do a soft reset, and start the process of creating commits.

After the reset, close out all editors, then run GitLens's "Open All Changes (difftool)".  This way, I can quickly cycle through only the changes, not all the files, diffs, and terminals that I've had open in VS Code.  

Cyle through the changes, and get a sense for commits that can be split up.  Then commit hunks or entire files; whatever makes sense for the commit I'm trying to make.  

Stash all the changes, and run the formatters, linters, and mypy.  This way, every commit is formatted properly—it's a working piece of code, that doesn't require any changes to work.

After working through the commits, do a final rebase.  They should be clean, given the process above.  At this point, the purpose is to ensure I won't have any conflicts, make sure the commits are in order, and make sure that I didn't commit anything weird or dumb.
