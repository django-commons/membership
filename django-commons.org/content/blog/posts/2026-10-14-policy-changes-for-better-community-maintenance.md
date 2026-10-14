---
date: 2026-10-14
title: "Policy changes for better community maintenance"
description: "We have agreed upon new policy changes around dormant and archived projects that better reflect community-maintained packages."
author: Tim Schilling
categories:
  - Announcements
tags:
  - governance
  - sustainability
---

The Django Commons Admins Team adopted [new governance policies around project maintenance](/governance/project-maintenance/) and a [new default security policy](https://github.com/django-commons/.github/blob/main/SECURITY.md).

These changes were made to empower our organization to support our community-maintained packages.

## Project Maintenance Governance

Originally, Django Commons would only accept actively maintained projects. These changes allow the organization to accept projects that are archived or lack active project admins. It also defines what the Django Commons Admins can do when a maintainer is no longer active. A project is considered dormant when, for example, its project admins have been inactive for six months, or it hasn't had a release within six months of a new major Django version.

Mainly, it allows the admins to cut a release for a project provided the changes in it are minor. If the package only needs to update the test suite and classifiers, then the release is fairly low risk, and a trusted person in the community should be empowered to perform that release. That is precisely what an admin is in this case.

This kind of stewardship is meant to be temporary. A project should either find new maintainers or be archived, and archiving is a perfectly normal outcome in open source.

The admins will not be actively developing any project, nor will they release major refactors. Those require active project admins and are a separate problem.

## Trust Ladder

The new policy also highlights [a trust ladder for new contributors](/governance/project-maintenance/#contributor-trust-ladder-for-dormant-and-archived-projects). For most contributors it has four steps:

1. **Open contribution.** Anyone can send a pull request. No special permissions are needed.
2. **Project members team.** Triage permission to manage issues and pull requests. This is a deliberately low bar.
3. **Project committers team.** Permission to push branches and review and merge pull requests, but not to cut releases.
4. **Project admin team.** Full stewardship of the project, including publishing releases.

Please note that if a project is dormant or archived, it may be difficult for a new contributor to become a project admin of the project solely through contributing to that project. Becoming a project admin implies you are trusted by the community and are knowledgeable of the domain of the package. It requires someone else who has one or both of those things to vouch for you, and for dormant and archived projects that is the Django Commons Admins' call. Moving up isn't automatic or based on time. Contributors with a strong open source track record may skip ahead, and a short conversation with the admins is also a valid way to establish trust.

If you'd like to help with a dormant or archived project, [open an issue in the membership repository](https://github.com/django-commons/membership/issues/new?template=admin-request.yml) and tell us what you have in mind.

## Default Security Policy

The new default security policy can be overridden by individual projects. We wanted to adopt a policy that highlights that the admin team can get involved in responding to security reports so that the project admins aren't operating in isolation. Reports go through GitHub's private vulnerability reporting on the affected repository, and maintainers acknowledge them within two weeks. If nobody responds, reporters can email the admin team.

These guidelines were adapted based on [Django's security policy](https://docs.djangoproject.com/en/dev/internals/security/) and [Python's security policy](https://devguide.python.org/security/policy).

<!-- Questions or feedback? Join the conversation on the [Django Forum](TODO). -->
