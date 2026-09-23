# Open Collective

Django Commons projects can accept donations through a project under the
[Django Commons Open Collective](https://opencollective.com/django-commons). Our fiscal host is
[OS Collective](https://docs.oscollective.org/), which holds the funds and pays out expenses.

To get started, [create a request for the Django Commons Admins](https://github.com/django-commons/membership/issues/new?template=admin-request.yml).
The Django Commons Admins will create the Open Collective project and invite the repository's admins to it.
The repository's admins then work through the steps below.

## Donations are not payment for services

OS Collective does not allow us to accept funds in exchange for goods or services. When maintainers
promise something and don't deliver, sponsors ask for refunds. Avoid promising goods or services
in exchange for donations anywhere on your Open Collective project, including tiers.

Your project's About section must include this disclaimer:

> All contributions are voluntary donations without guaranteed services or benefits, even where
> tier descriptions suggest potential acknowledgments or features.

## Decide how funding works

The repository's admins need to answer the following questions and post the answers in the
repository's [GitHub Discussions check-in thread](https://github.com/orgs/django-commons/discussions/categories/check-ins).

The answers for eligibility and division must be objective, so the Django Commons Admins can review
them if there is a dispute.

### What is the funding for?

This shapes your message to sponsors and the tiers on your
[Open Collective project](https://documentation.opencollective.com/collectives/managing-money/projects).

Examples:

- Paying maintainers for their time
- Development expenses such as tools and hosting
- An internship program for junior developers

Open Collective supports both
[reimbursing expenses and paying invoices](https://docs.oscollective.org/for-hosted-member-projects/spending-money-and-getting-paid/invoice-and-reimbursement-examples).

### Who can receive funding?

Examples:

- Members of the `django-commons/<repository>-admins` team
- Members of the `django-commons/<repository>-admins` and `django-commons/<repository>-committers` teams

If you fund people for specific project work, we recommend paying out
[similar to Google Summer of Code](https://developers.google.com/open-source/gsoc/help/student-stipends):
pay in two parts, at the halfway point and at the end. Define deliverables up front so you can
decide whether a payout is earned. Consider whether someone who advanced the project, but didn't
finish the feature, should still be paid.

### How is funding divided?

Examples:

- An equal split among all team members
- An agreed ratio between team members, revisited quarterly

## Set up your Open Collective project

In the steps below, replace `<repository>` with your project's slug on Open Collective.

### Project info

Fill in your project info at `https://opencollective.com/dashboard/<repository>/info`:

- **Logo**: If you need one, ask [@django-commons/designers](https://github.com/orgs/django-commons/teams/designers)
  in [GitHub Discussions](https://github.com/orgs/django-commons/discussions).
- **Short title**: A call to action. For example, "Support the fantastic Django third-party project!
  We're pushing the boundaries on middlewares."
- **About**: Explain what the funding is for, why it matters, and how it's divided. Help sponsors
  feel confident in, and appreciated for, supporting your project. This must include the
  [disclaimer](#donations-are-not-payment-for-services).

### Donor email

Customize the email sent to donors at `https://opencollective.com/dashboard/<repository>/custom-email`.
Thank them and remind them what their donation supports. For example:

> Thank you for contributing to <repository>! We deeply appreciate your donation. As a reminder,
> all contributions are voluntary donations without guaranteed services or benefits, even where
> tier descriptions suggest potential acknowledgments or features.
>
> By donating to the project, you have:
>
> - Directly contributed to higher quality software.
> - Allowed more time to be invested in documentation, triage, and support.
> - Safeguarded the future development of <repository>.
>
> Once again, thank you!

### Tiers

Set up tiers at `https://opencollective.com/dashboard/<repository>/tiers`. Tiers must not promise
goods or services (see [above](#donations-are-not-payment-for-services)).

Examples from other projects:

- [allauth](https://allauth.org/sponsors/)
- [Django REST framework](https://opencollective.com/django-rest-framework)

## Getting paid

- [Submitting invoices](https://docs.oscollective.org/for-hosted-member-projects/spending-money-and-getting-paid/invoice-and-reimbursement-examples#invoices)
- [Submitting reimbursements](https://docs.opencollective.com/help/expenses-and-getting-paid/submitting-expenses#reimbursements)

## Other features

Open Collective also supports
[goals](https://documentation.opencollective.com/collectives/raising-money/setting-goals-and-tiers#goals),
[budgets](https://documentation.opencollective.com/collectives/managing-money/budgets), and
[updates](https://documentation.opencollective.com/advanced/keeping-your-community-updated/updates-and-contact).
We haven't explored all of these. If you find something that works well, please share it so we
can add it to this page.
