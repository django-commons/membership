# Project Maintenance Governance

<!-- [Google Doc Link](https://docs.google.com/document/d/1LmUZszX4a0C9ess6c1WDIkWUrc5HMtIY22JMPs3sWvY/edit?usp=sharing) -->

## Overview

Django Commons creates the conditions for maintainership to transfer smoothly so that when maintainers step back, the community has a clear path to step in.

This document will outline the various states a project can be in, how a project transitions between them, and where support is provided.

---

## Maintenance States

### Healthy

A project has a responsive maintainer, clear ownership, regular releases, and an active repository.

### Dormant

A project has an unresponsive maintainer, a lack of forward compatibility, and potentially community complaints.

#### Determining a project to be dormant

A project is determined to be dormant when any of the following occur:

* A lack of activity across issues, pull requests, commits, and releases from the project admins for a period of **six months**
* A lack of a release within **six months** of a major Django version release (5.0, 5.1, 5.2, etc.)
* A **critical bug** has gone unaddressed for a significant period
* A **security vulnerability** has been reported and not acknowledged within the timeframe for its severity, as defined in [response timeframes](../response-timeframes.md)

#### Review of applications for maintainers from the Django Commons Community

When a project has been determined to be dormant, members of the Django Commons community may put themselves forward as maintainers of the project. The Django Commons admins (`@django-commons/admins`) will review the applicant and decide based on:

1. Tenure of membership with Django Commons, Django, and Python communities
2. Work already done on the project, both merged and unmerged PRs
3. Engagement with the project maintainer as evidenced by comments on PRs and/or discussions in the repos discussions (if they exist)

### Commons Stewardship

The Django Commons admins (`@django-commons/admins`) have direct administrative control to ensure the health of the ecosystem. This is a temporary state, and projects aren't meant to be here long term. Projects should either have new maintainers identified or be archived.

**What admins will do:**

* Make minor releases to unblock downstream Django applications from upgrading dependencies. These releases should be minor in substance and may involve small changes, such as when Django moved to a single `STORAGES` setting.

**What admins will not do:**

* Actively develop the project as a team. Admins can participate as individuals, but not in an official capacity.
* Perform major refactors. That requires one or more engaged project admins who can maintain and support those changes over time.

### Archived

No active maintenance is expected. The repository is retained for historical or referential purposes.

Having archived packages is a normal outcome in open source. If no contributor steps forward to adopt an abandoned project, archiving is a valid and expected path.

---

## Contributor Trust Ladder for Dormant and Archived Projects

> **Note:** This section applies only to **dormant and archived projects** being adopted by a new contributor. Active projects with existing maintainers are self-organizing — current maintainers decide when and how to onboard new contributors, committers, or co-maintainers without Django Commons involvement.

Django Commons takes a case-by-case approach to granting access to new contributors for abandoned projects. The goal is to avoid placing excessive operational burden on the Django Commons admins (`@django-commons/admins`) while still ensuring trust is established before handing over control.

### For contributors new to open source or without a strong public profile:

The following staged path applies.

#### Open Contribution

*Goal: Establish a track record of quality contributions. This level requires no team membership at all.*

During this stage, anyone is welcome to contribute to the project without requiring any special permissions beyond a standard fork-and-PR workflow.

* There is no expectation that a contributor will advance; some contributors may be happy to stay at this level indefinitely.
* Contributors who are interested and show consistent, high-quality engagement are welcome to join the Committers Team for the project.
* A person can request to join by [creating an issue](https://github.com/django-commons/membership/issues/new?template=admin-request.yml) explaining why they want to contribute and what their plans are for the project.

#### Project Committers Team

*Goal: Enable a trusted contributor to work more autonomously on non-release work. This level is aligned with the project committers team, `@django-commons/<project>-committers`.*

Contributors who have demonstrated reliable judgment may be invited to join the committers team, which grants:

* Permission to create branches directly in the repository
* Commit access to non-protected branches

The following remain restricted to the project admin team (`@django-commons/<project>-admins`) and the Django Commons admins (`@django-commons/admins`):

* Merging into the main/protected branch
* Cutting releases and publishing to PyPI
* Changing repository settings, branch protection rules, or secrets

If a project lacks a project admin team, the Django Commons admins continue to review and approve all releases and will actively collaborate with the contributor on significant changes before they land.

#### Project Admin Team

*Goal: Formally hand stewardship of the project to a trusted maintainer. This level is aligned with the project admin team, `@django-commons/<project>-admins`.*

After sustained, demonstrated trustworthiness as a committer, including sound judgment on security, responsiveness to feedback, and alignment with Django Commons values, a contributor may be elevated to full maintainer.

The new permissions are:

* The ability to publish releases
* Define the governance for the project

Progression is not automatic or time-based. It requires a conscious decision by the Django Commons admins, ideally discussed openly in the membership repository. A contributor can be moved back to a previous stage if serious concerns arise.

### For contributors with a strong open source profile:

If a contributor has a clearly established track record, like a strong commit history, active public repositories, or prior open source work, the Django Commons admins may grant commit access directly, skipping the early stages. Release access may follow at their discretion.

### For contributors assessed via a direct conversation:

A short call or interview with the Django Commons admins is a valid path to establishing trust. Relevant signals include:

* Talks or presentations at Python or Django conferences or meetups
* Attendance or organizing of such events
* Other demonstrable community involvement

Release access is always decided on a case-by-case basis by the Django Commons admins. There is no automatic progression to release access regardless of which path a contributor takes.

