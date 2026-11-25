---
date: 2026-11-25
title: "Admins Meeting Notes: 2026-11-25"
description: "The public meeting notes from the Django Commons admin team."
author: Django Commons Admins
categories:
  - Meeting Notes
tags:
  - admins
attendees:
  - Daniel Moran
  - Tim Schilling
apologies:
  - Tilda Udufo
  - Ryan Cheley
  - Brian Kohan
  - Daksh P. Jain
---

## Actions

- Brian: Add to Best Practices suggested guidelines for releasing support for updated versions of Django / Python
- Brian: Look into ReadTheDocs domain hijacking for packages that don’t use RTD.
- Brian: Investigate [django-commons.org](http://django-commons.org) email address
- Tilda: Help with inbound project transfers
- [TBD]: Explore limited control for DNS records with django unicorn
- Daksh: Create automation for adding new inbound projects to the website
- Tim: Revisit add_member action
- ~~Tim: Reach out to DRF maintainers~~
- ~~Daniel: Assign new package transfers to self~~

##  Agenda

- Who is posting public notes? Tim
- Security of GitHub actions
    - [https://alpha-omega.dev/blog/de-fanging-dangerous-triggers-in-github-actions-across-an-organization/](https://alpha-omega.dev/blog/de-fanging-dangerous-triggers-in-github-actions-across-an-organization/)
    - Add_member.yml is likely susceptible
    - pull_request_target  comment_created
    - Tim is going to look at revisiting this
- Transfers review
    - While it’s slow, it’s progressing
    - Projects transferring issues are being created without checking the CoC checkbox. We need to be sure they do adopt the CoC in the repo itself regardless.
    - Dataviz wasn’t sure if django commons would accept non-django packages
        - Tim communicated with Dan that it could come in and offered to help on any thread if it comes up
    - [https://github.com/orgs/jazzband/projects/16](https://github.com/orgs/jazzband/projects/16)
    - Next meeting, let’s revisit the list and assign folks to any open issues
        - Auditing pypi
        - Starting discussion threads
        - Auditing Read the Docs
        - List of max version of Django supported, then from there reach out to maintainers for their plan
            - Could go on projects spreadsheet
- Tim: Recruiting new admins
    - Do we want to backfill Storm/Lacey roles?
    - We could reach out to candidates for the board and steering council for those who don’t get elected?
    - We want to have people contribute as a non-admin
        - This would require us to open up meetings and encouraging people to participate more
    - Daniel: Probably not worth adding more people just yet.
- How do we cultivate more engagement with the Django Commons organization?
