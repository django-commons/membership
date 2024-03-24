# Requirements for Incoming Repositories

Thank you for looking at Django Community to help maintain your
repository! We're here to help however is best for both the project
and the community.

To see how to transfer a project into Django Community, see
[How to transfer a project in?](https://github.com/django-community#how-to-transfer-a-project-in).

## Repository requirements

There are a few requirements that must be met before a project can
be transferred in.

1. Tests that run in CI
2. Maintained documentation
3. Adopt [Django Community's Code of Conduct](https://github.com/django-community/membership/blob/main/CODE_OF_CONDUCT.md)
4. After transferring, switch to [PyPI's "Trusted Publisher"](https://docs.pypi.org/trusted-publishers/)
   process (see [example in django-community-playground](https://github.com/django-community/django-community-playground/blob/main/.github/workflows/release.yml))

### Tests

There should be clear instructions on how to run the tests. The tests
should have good test coverage (>70%). The tests should cover all supported
versions of Python and Django (exceptions can be made for new versions with
a less involved maintainer).

### Documentation

There should be quality documentation on how to install and use the
project. The documentation should be organized and maintainable.

Internationalized documentation isn't required, but is ideal.

An [architecture documentation section](https://matklad.github.io/2021/02/06/ARCHITECTURE.md.html)
is highly recommended, but not required.

### Code of Conduct

The repository must adopt Django Community's Code of Conduct. It should
directly link to https://github.com/django-community/membership/blob/main/CODE_OF_CONDUCT.md

## Maintainer requirements

The current maintainers must be willing to hand over control of the
PyPI project. The Django Community admins team and the
Django Community's repository admin team specific to this repo will
accept possession of the PyPI project.

The repository must identify which people will be the new 
maintainers moving forward. This can contain existing maintainers.

If desired, the current maintainers can temporarily join the
Django Community's repository admin team to ensure the project's
standards are met during the process. Being on this team gives
them all the controls they would need to transfer the repository
out of Django Community, back under their control. After the trial
period, they may be removed from Django Community's repository admin
team. Regardless, it's recommended that a project go through the
formal [transfer a project out of Django Community](https://github.com/django-community#how-to-transfer-a-project-out)
process.

## Funding

This is still in the works for Django Community. If a repository
has a prior funding arrangement, that can continue provided any
future maintainer receives an equal share. Additionally, if Django
Community defines a formal funding policy, that must be adopted by
the repository.
