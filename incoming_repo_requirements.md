# Requirements for Incoming Repositories

Thank you for looking at Django Commons to help maintain your
repository! We're here to help find what is best for both the
project and the community.

To see how to transfer a project into Django Commons, see
[How to transfer a project in?](https://github.com/django-commons/membership/blob/main/README.md#how-to-transfer-a-project-in).

There are a few requirements that must be met before a project can
be transferred in.

1. All maintainers (people with release permissions) agree to the transfer
2. New admins and maintainers are identified
3. [Tests that run in CI](#tests)
4. [Maintained documentation](#documentation)
5. Adopt [Django Commons's Code of Conduct](#code-of-conduct)
6. After transferring, switch to [PyPI's "Trusted Publisher"](https://docs.pypi.org/trusted-publishers/)
   process (see [example in django-commons-playground](https://github.com/django-commons/django-commons-playground/blob/main/.github/workflows/release.yml))
7. If there is a JavaScript component published separately to NPM, it needs to be transferred to a new team under the [django-commons npm organization](https://www.npmjs.com/org/django-commons) and automated releases are to be set using [npm trusted publishing](https://docs.npmjs.com/trusted-publishers). If the project is already scoped under a different organization (`@your-org/your-package), this unfortunately means that package will need to be deprecated and a new package created, preferably without a scope, as there is no way to transfer packages between scopes on npm.
8. django-commons should be added as maintainer to the readthedocs project

## Repository requirements

### Tests

- **[Required]** Clear instructions on how to run tests
- **[Required]** Tests run with at least oldest supported LTE versions of Django and Python
- [Suggested] Good test coverage (>70%)

### Documentation

- **[Required]** How to install and use the project
- **[Required]** How to contribute
- **[Required]** Organized and maintainable
- [Suggested] Contains [architecture documentation](https://matklad.github.io/2021/02/06/ARCHITECTURE.md.html)


### Code of Conduct

- **[Required]** Repository contains `CODE_OF_CONDUCT.md` that links to [Django Commons's Code of Conduct](https://github.com/django-commons/membership/blob/main/CODE_OF_CONDUCT.md). See [django-commons-playground](https://github.com/django-commons/django-commons-playground/blob/main/CODE_OF_CONDUCT.md) for an example


## Maintainer requirements

- **[Required]** All maintainers (release permission) agree to transfer project
- **[Required]** The repository will be transferred to the [django-commons GitHub organization](https://github.com/django-commons)
- **[Required]** The Django Commons PyPI admin team (`cunla` and `stormheg`) is added as owners to PyPI and Test PyPI projects
- **[Required]** Any previous maintainers who are not repository admins are removed as owners on PyPI and Test PyPI projects
- **[Required]** If applicable, any separately published JavaScript package is transferred to the [django-commons npm organization](https://www.npmjs.com/org/django-commons) and any previous maintainers who are not repository admins are removed as owners. Two factor authentication must be enabled.

The current maintainers must be willing to hand over control of the
PyPI project. The Django Commons admins team and the
Django Commons's repository admin team specific to this repo will
accept possession of the PyPI project.

The repository must identify which people will be the new 
maintainers moving forward. This can contain existing maintainers.

If desired, the current maintainers can temporarily join the
Django Commons's repository admin team to ensure the project's
standards are met during the process. Being on this team gives
them all the controls they would need to transfer the repository
out of Django Commons, back under their control. After the trial
period, they may be removed from Django Commons's repository admin
team. Regardless, it's recommended that a project go through the
formal [transfer a project out of Django Commons](https://github.com/django-commons/membership/blob/main/README.md#how-to-transfer-a-project-out)
process.

## Funding

This is still in the works for Django Commons. If a repository
has a prior funding arrangement, that can continue provided any
future maintainer receives an equal share. Additionally, if Django
Commons defines a formal funding policy, that must be adopted by
the repository.
