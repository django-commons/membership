# Django Commons Governance

<!-- [Google Doc Link](https://docs.google.com/document/d/14x-svksM6aqU-nPVvScm6fSgCyzQbWxaUR1MeMeCDoQ/edit?tab=t.0#heading=h.gbkvb0hnum4b) -->

For Django Commons to function effectively, we need trusted volunteers to step up and take responsibility for certain aspects that require ongoing attention and a certain level of trust from our community. These volunteers are organized into teams, each with a specific focus.

## Relation to the Django Software Foundation

Django Commons is an independent initiative from the Django Software Foundation (DSF). We are here for the third-party packages that complement Django. We are here as a community for and by Django users.

## Teams

There are three teams that work together to handle the operations of Django Commons.

They are:

- [Admin Team](#admin-team)
- [Super Admin Team](#super-admin-team)
- [CoC Team](#code-of-conduct-team)

## Communication

Our teams use two main ways to communicate: GitHub Discussions and team related Google Group email.

Quick guide:

- Use [GitHub Discussions](https://github.com/orgs/django-commons/discussions) for: technical questions, project ideas, general help, and community discussions.
- Use [GitHub private vulnerability reporting](https://docs.github.com/en/code-security/security-advisories/guidance-on-reporting-and-writing-information-about-vulnerabilities/privately-reporting-a-security-vulnerability#privately-reporting-a-security-vulnerability) for: security concerns.
- Use [Google Group email](mailto:django-commons-admin@googlegroups.com) for: personal matters, sensitive information, or private volunteer concerns.

We believe in being open and transparent, so we encourage everyone to use GitHub Discussions as their first choice. This public space lets everyone see and join our conversations, which helps new volunteers learn from past discussions and feel included in our community.

## Admin team

This is the core team that is responsible for the overall management of the organization. They have admin access to the GitHub organization and are responsible for making sure that Django Commons is running smoothly.

Responsibilities/tasks include:

- Manage new membership applications.
- Respond to inquiries from the community on the [Discussion forum](https://github.com/orgs/django-commons/discussions).
- Manage all team rotation schedules, making sure that every team is actively staffed in a sustainable manner.
- Encourage people from diverse backgrounds to join one of the teams.
- Provide resources and facilitate projects seeking new or additional maintainers. Help find new maintainers for projects that need them.
- Facilitate discovery of maintenance best practices.
- Conduct check-ins with project maintainers and our community.
- Maintain this document and other documents that describe how Django Commons operates.
- Attend regular team meetings to discuss the state of Django Commons and what we can do to improve it.
- Help organize events and other community activities.
- Reach out to projects that might be interested in joining Django Commons.
- Supporting projects maintainers in handling security reports by providing advice or guidance.
- Being a backup contact point for security reporters when project maintainers fail to respond to a security report.
- In cases where a maintainer is unresponsive, the admin team may take over the project to fix the security issue at their discretion.

Out of scope responsibilities/tasks:

- Maintaining projects. This is the responsibility of the maintainers of the projects themselves. However, admin team members are free to contribute to projects as they see fit. There is just no expectation that they do so.
- Yanking packages from PyPI - this should be done by project maintainers in coordination with the PyPI team. An exception is made when the project maintainer is [unresponsive](unresponsive.md).

Qualifications for admin members (any of the following):

- Be a Django Commons member

### Team governance

The admin team has a minimum of three and a maximum of ten members. The exact number is determined by the admin team from time to time. The size of the admin team should reflect the workload and responsibilities of the team; as the needs of the organization change, the size of the admin team will adjust by vote. (Example: during transition periods, the size of the admin team may need to be larger.)
The admin team may change around September.  In August, the admin team will put out a public call to its membership to gauge interest in joining the admin team. Based on that interest, the admin team will decide:

- The size of the admin team for the upcoming term.
- Whether team changes are needed, or whether some admins can step down to make room for new admins.
- Which admins will step down, and which will continue to serve.

At this time, the process for selecting new admin team members is based around the current admin team interviewing candidates it deems suitable. An election process was considered but as of April 2025, the admin team feels Django Commons has not matured enough for elections to provide tangible benefits over self-selection.

We strive to have a team [reflective of our values](values.md).

### Means of communication

The admins internally communicate via the django-commons-admin@googlegroups.com mailing list and through admin meetings. The discussion taking place on the mailing list is private and only visible to admin team members. However, the team should aim to operate transparently and use public channels, like posting to GitHub Discussions, when possible.

To contact the admin team, open an [Admin request issue on the membership repo](https://github.com/django-commons/membership/issues/new/choose). You can also publicly tag the `@django-commons/admins` team on GitHub to get our attention. If you need to reach out privately to the admin team, you can do so by sending an email to django-commons-admin@googlegroups.com.

To report a security issue, please use [GitHub’s private vulnerability reporting](https://docs.github.com/en/code-security/security-advisories/guidance-on-reporting-and-writing-information-about-vulnerabilities/privately-reporting-a-security-vulnerability#privately-reporting-a-security-vulnerability) on the relevant repository.

## Super Admin team

The Super Admin team is responsible for performing privileged operations and safeguarding GitHub and PyPI access to all projects hosted by Django Commons.

Responsibilities/tasks include:

- Manage incoming transfers and outgoing transfers of projects.
- Maintain the [django-commons/membership](https://github.com/django-commons/membership) repository.
- Maintain the [django-commons/controls](https://github.com/django-commons/controls) repository.
- Maintain the Django Commons 1Password account
- Managing PyPI access for all projects hosted by Django Commons.
- Adding and removing users from projects as needed.
- Helping project maintainers set up automated releases for their projects.
- Helping project maintainers with any other issues they have with PyPI.
- Monitoring for any suspicious activity on PyPI, through email notifications sent by PyPI and other means, and follow-up with the repo's admins.
- Responding to any security incidents that occur related to PyPI.
- Have Owner role on all PyPI and Test PyPI projects for Django Commons.
- Have MFA set up with PyPI and Test PyPI.
- Updating project admins access in PyPI and Test PyPI to reflect GitHub team membership.

Out-of-scope responsibilities/tasks:

- Making releases. This is the responsibility of the maintainers of the projects themselves.
- Yanking releases that have issues/bugs. This is the responsibility of the maintainers of the projects themselves. An exception is made for security issues or other issues that require immediate action.

Qualifications for admin members (any of the following):

- Be a [DSF Individual Member](https://www.djangoproject.com/foundation/individual-members/)
- Been an active Django Commons member for 6 months

### Team governance

Members of the Super Admin team are appointed by other members of the super admin team.
The Super Admin team has a rotation schedule of 12 months, given the overall low workload and effort required to onboard and offboard members. The team has a preferred size of 2-3 members. This is to balance the number of people with unlimited access to PyPI and the [bus factor](https://en.wikipedia.org/wiki/Bus_factor) associated with a small group of people.
The rotation schedule coincides with the rotation schedule of the admin team, centered around October 1st as the start of the cycle.

### Means of communication

The admins internally communicate via the django-commons-admin@googlegroups.com mailing list and through admin meetings. Requests can be made directly by tagging the `@django-commons/super-admins` team on GitHub.

## Code of Conduct team

The Code of Conduct team is responsible for handling complaints of Django Code of Conduct violations that occur in the Django Commons community.

Responsibilities/tasks include:

- Investigating and responding to complaints of Code of Conduct violations.
- Making decisions on how to handle complaints of Code of Conduct violations.
- Communicating with the person who made the complaint and the person who the complaint is about and any other relevant parties.
- Keeping records of complaints and how they were handled.
- Utilize the [Code of Conduct Working Group’s](https://github.com/django/dsf-working-groups/blob/main/active/code-of-conduct.md) recommendations and any other relevant DSF Working Group recommendations regarding code of conduct.

### Team governance

The Code of Conduct team has no set rotation schedule. Members can step down at any time and interested parties can reach out to the admin team if they are interested in being part of the code of conduct team. The admin team is responsible for periodically checking in to make sure all members are still okay in continuing their role and is tasked with finding replacements if needed. Admin team members are allowed to be on the Code of Conduct team too if they wish.

The preferred size of the Code of Conduct team is 2-5 members. This is to make sure that the workload is distributed evenly and to allow for more diversity of thought and perspective.

### Means of communication

The Code of Conduct team communicates via the django-commons-coc@googlegroups.com mailing list.