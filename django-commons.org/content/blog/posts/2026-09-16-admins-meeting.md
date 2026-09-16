---
date: 2026-09-16
title: "Admins Meeting Notes: 2026-09-16"
slug: admins-meeting
description: "The public meeting notes from the Django Commons admin team."
author: Django Commons Admins
categories:
  - Meeting Notes
tags:
  - admins
attendees:
  - Ryan Cheley
  - Tim Schilling
  - Storm Heg
  - Daksh P. Jain
apologies:
  - Tilda Udufo
  - Daniel Moran
  - Brian Kohan
---

## Actions

- Brian: Add to Best Practices suggested guidelines for releasing support for updated versions of Django / Python (Brian)
- Brian: Look into ReadTheDocs domain hijacking for packages that don’t use RTD.
- Daksh: Update media page with Daksh’s lightning talk from EuroPython
- ~~Daksh to create a meeting poll for an open issues discussion~~
- ~~Tim: Review Storm post draft~~
    - [https://github.com/django-commons/membership/pull/562](https://github.com/django-commons/membership/pull/562)
- ~~Tim: Follow up with Daniel, Tilda, Brian on public notes~~
- Tim: Draft public notes LLM action and initial
- All: Review [the open issues](https://github.com/django-commons/controls/issues), see if anything should be closed or if there’s something of interest to you
- [TBD]: Explore limited control for DNS records with django unicorn
- [TBD]: Draft initial public notes and action
- [TBD]: Draft message for the community around

## Agenda

- Storm stepping down
    - Storm has a new full-time job that is taking up the previous OSS time
    - Review [Storm Post Draft](https://github.com/django-commons/membership/commit/9325c7d0fc3a44c95808cacf8d5a2f5ceff09b3d)
    - DNS
        - [desec.io](http://desec.io) - confirmed working
    - Is planning for the end of the month Sep 30th.
- Revise contribution guidance controls PR:
    - [https://github.com/django-commons/controls/pull/99](https://github.com/django-commons/controls/pull/99)
    - On adding PyPI metadata for description on meaningful metrics
        - Tim: suggestion to remove basing it on the meaningful metrics
        - Storm: Concern with adding it to PyPI because releases don’t get cut often
            - Tim: The changes don’t necessarily need to fit into the existing release flow
            - There would be an issue going from active to dormant, there could be changes that haven’t been released. We would need to decide if those get released or not.
        - Badges on PyPI could have the images updated
            - How does caching work with this?
                - Would need to see what the cache level is
                - What would be the impact of this
            - Is changing the underlying files worth the work
    - Daksh: Would a maintainer be opposed to including a badge in the README
        - Not sure, we haven’t tried doing this before.
        - We should have consistency in our projects on badges and README notice about Django Commons
        - Communication plan
            - Draft a message for the maintainers on what we want to change around readme, badges, pypi
            - Update the best-practices repo
            - Create PRs and make it optional
- Tim: Public notes
    - DSF Board has public and private comments, along with confidential information that they are hidden.
    - Storm/Ryan: Could publish public meeting notes as blog posts on the site, then share in other places
    - The four of us are in agreement, not quite sure on where it should go
    - Tim: I would like it if we have notes published in the forum so that the whole community can find things in the same place
    - Storm: I’d prefer a markdown file in a repo to follow-along
    - Proposed Logistics
        - Do the meeting minutes in the docs website
        - Use an LLM action to convert from google to markdown
        - Publish to the site
        - Share on the forum
- Tim: Review controls repo open issues: [https://github.com/django-commons/controls/issues](https://github.com/django-commons/controls/issues)
    - Ryan: We can try to review these before next month’s meeting and do some triaging and/or discuss
