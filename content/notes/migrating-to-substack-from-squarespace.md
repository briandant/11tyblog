---
tags: note
layout: layouts/note.liquid
title: migrating to substack from squarespace
date: "git Created"
---

I'm helping a friend to migrate to Substack from Squarespace.  We've gotta handle the URL redirects, of course.  

1. Import your site with the Substack tool.  To preserve the URLs, use the Import Posts tool in Substack, choosing the RSS feed option (can't remember why I did this instead of the basic URL).  You'll have to page through your posts and bring in, e.g., 10 at a time.
a. The important thing here is that the last part of the path remains intact (that is, the `last` in `https://example.com/foo/bar/last`).
2. Set up a Cloudflare site for your domain
3. Set up the custom domain in Substack
a. Ignore the warning about disabling proxying—you need it (but maybe that's too risky—see more [here](https://www.devbrief.com/p/cloudflare-redirects-substack-guide))
4. Add a `CNAME` record in Cloudflare:

    ```sh
    CNAME yoursite.com `target.substack-custom-domains.com`
    ```

5. Add an A record, if your site was using the `www.` subdomain and you want to preserve the links:

    ```sh
    A www 192.0.2.1
    ```

6. Create a redirect rule in Cloudflare:

    ```sh
    FROM: https://www.yoursite.com/*
    TO: https://yoursite.com/${1}
    ```

The rule works because:

1. The A record with `192.0.2.1` is not a real A record.  Cloudflare allows you to use it simply to trigger your redirect rules.  
2. Substack will redirect anything that matches the `last` part of the path: `foo/bar/last` will redirect to `p/last`, and the user will get the content.
