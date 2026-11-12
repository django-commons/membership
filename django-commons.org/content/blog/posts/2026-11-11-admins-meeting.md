---
date: 2026-11-11
title: "Admins Meeting Notes: 2026-11-11"
description: "The public meeting notes from the Django Commons admin team."
author: Django Commons Admins
categories:
  - Meeting Notes
tags:
  - admins
attendees:
  - Ryan Cheley
  - Daniel Moran
  - Daksh P. Jain
  - Tim Schilling
apologies:
  - Brian Kohan
  - Tilda Udufo
---

## Actions

- ~~[thanks.dev contributions](https://docs.google.com/spreadsheets/d/1ABTlpoqBzdTwiYbHda3slpTxx_d6aVePK0LCTtfn__0/edit?gid=0#gid=0) updated~~
- Brian: Add to Best Practices suggested guidelines for releasing support for updated versions of Django / Python
- Brian: Look into ReadTheDocs domain hijacking for packages that don’t use RTD.
- Brian: Investigate [django-commons.org](http://django-commons.org) email address
- ~~Brian: Invite Ryan to Alpha-Omega meeting~~
- Tilda: Help with inbound project transfers
- \[TBD\]: Explore limited control for DNS records with django unicorn
- ~~Daniel: Update new project transfer (controls + PR template) to include:~~
  - ~~update [docs yaml](https://github.com/django-commons/membership/blob/main/django-commons.org/data/projects.yaml)~~
  - ~~Update [spreadsheet](https://docs.google.com/spreadsheets/d/1MV0IGyS32EY_NtEq67MMYj2bqOv05imF5QP6I1KGhF8/edit?gid=0#gid=0)~~
  - ~~[https\://github.com/django-commons/controls/pull/115](https://github.com/django-commons/controls/pull/115)~~
  - ~~[https\://github.com/django-commons/membership/pull/699](https://github.com/django-commons/membership/pull/699)~~
- ~~Daniel: Update new projects in [docs yaml](https://github.com/django-commons/membership/blob/main/django-commons.org/data/projects.yaml) - [https\://github.com/django-commons/membership/pull/697](https://github.com/django-commons/membership/pull/697)~~
- ~~Daniel: Update [spreadsheet](https://docs.google.com/spreadsheets/d/1MV0IGyS32EY_NtEq67MMYj2bqOv05imF5QP6I1KGhF8/edit?gid=0#gid=0) with new projects~~
- Daksh: Create automation for adding new inbound projects to the website
- Daksh: Update public notes for this meeting

## Agenda

* Who is posting public notes?
  * Daksh
* Alpha-Omega update
  * Discussion with Mirko, mainly introductions with [Alpha-Omega](https://alphaomega.com/)
  * They will follow-up with us
  * Alpha-Omega is the company that funds the Security in Residence program that employs Seth Larson and Mike Fielder
* Updating website for new packages
  * Is this automatic or manual?
  * Manual, but there’s a yaml file to be updated ([projects.yaml](https://github.com/django-commons/membership/blob/main/django-commons.org/data/projects.yaml))
    * Could fetch from GitHub API
    * Have the update trigger based on pull request template
* Daniel: Updated the token for GitHub and Tofu interactions
  * Will schedule a reminder for the team in X months
  * Daksh: How does a person update the Tofu state?
    * [https\://github.com/django-commons/membership/tree/main/terraform](https://github.com/django-commons/membership/tree/main/terraform)
    * The Integration with GitHub Actions section describes the token and it relationships.
    * This is configured as an organization secret, but is scoped to just the membership repo.
    * Daksh will try to automate creating PR to update the yml file
* Jazzband transfer
  * Thoughts:
    * Ryan: It’s gone well, it’s nice to see the positive messages from Jannis posting updates and sharing information
    * Tim: It’s been moving along well, hope others feel comfortable participating
    * Daniel: There’s room for us to use a PR template to better track things.
  * Project board [https\://github.com/orgs/django-commons/projects/8](https://github.com/orgs/django-commons/projects/8)
    * The first two columns
  * Eventually, we need to:
    * Update project spreadsheet
    * Update website
    * Create Discussion threads for each project
    * Auditing pypi access on PyPI
    * Audit GitHub access on projects
      * Remove external contributors
    * Audit access Read the Docs, add maintainers to have access for managing things
  * Transifex
    * A project transferring into Django Commons had a project under the Jazzband Transifex org
      * Daksh created our org
    * Jannis is working to transfer the projects and/or organization to our newly created ones
* Automate new member PR merge message in issue
