# Django Commons

Django Commons is an organization dedicated to supporting the
community's efforts to maintain packages. It seeks to improve the
maintenance experience for all contributors; reducing the barrier
to entry for new contributors and reducing overhead for existing
maintainers.

Django Commons has lofty goals for the future, but it will only be
possible with your help:

- Identify and announce packages needing help
- Normalize and support maintainers periodically stepping back
- Support and encourage new contributors to step up
- Provide best practices for package maintainers
- Compensate maintainers

## How to join as a contributor?

1. Review [Code of Conduct](https://github.com/django-commons/membership/blob/main/CODE_OF_CONDUCT.md) 
2. Create a [new member issue in the django-commons/membership repository](https://github.com/django-commons/membership/issues/new/choose).

## How to transfer a project in?

1. A person with the ability to transfer the project must join Django Commons (see [How to join as a contributor?](https://github.com/django-commons#how-to-join-as-a-contributor))
2. Create a [transfer project in issue in the django-commons/membership repository](https://github.com/django-commons/membership/issues/new/choose).

## How to transfer a project out?

1. Create a [transfer project out issue in the django-commons/membership repository](https://github.com/django-commons/membership/issues/new/choose).

## FAQ

### What are the differences between Django Commons and Jazzband?

Django Commons and Jazzband have similar goals, to support community-maintained projects.
There are two main differences. The first is that Django Commons leans into the GitHub
paradigm and centers the organization as a whole within GitHub. This is a risk, given
there's some vendor lock-in. However, the repositories are still cloned to several people's
machines and the organization controls the keys to PyPI, not GitHub. If something were to occur,
it's manageable.

The second is that Django Commons is built from the beginning to have more than one administrator.
Jazzband has been [working for a while to add additional roadies](https://github.com/jazzband/help/issues/196)
(administrators), but there hasn't been visible progress.  Given the importance of several of
these projects it's a major risk to the community at large to have a single point of failure
in managing the projects. By being designed from the start to spread the responsibility, it
becomes easier to allow people to step back and others to step up, making Django more sustainable
and the community stronger.

### What is each respository team for?

There are three teams for each repository. They each have different
permissions.

- [project-name]
- [project-name]-committers
- [project-name]-admins

The general team [project-name] gives you triage permissions (assign issues, labels, etc).

The [project-name]-committers gives you permission to merge pull requests and push to main.
They are people who generally maintain the project.

The [project-name]-admins gives you permissions to administrate the GitHub repo and release new versions to PyPI.
This may be the same group of people that are on [project-name]-commiters.

### Who can work on a project?

Anyone can fork any project and work on any issue. All projects within Django Commons are community
maintained. If you're interested in working on a specific project, go get to work!

### Which repository is for what?

- [controls](https://github.com/django-commons/controls): This is for Django Commons administrators
  to manage the GitHub organization. Any issues in this repo are for maintain the magic behind the scenes
- [django-commons-playground](https://github.com/django-commons/django-commons-playground): An example repository for inbound repositories to copy
- [membership](https://github.com/django-commons/membership): The public face for the organization. All issues by members and contributors should be created
  here. **If you're looking for where to ask a question, this is the place for you**

## Credits

### Logo

Vectors and icons by [Raisul Hadi](https://dribbble.com/Broc_Simp?ref=svgrepo.com) in CC Attribution License via [SVG Repo](https://www.svgrepo.com/).
