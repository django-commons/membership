# Frequently Asked Questions

## What are the differences between Django Commons and Jazzband?

Django Commons and Jazzband have similar goals, to support community-maintained projects.
There are two main differences. The first is that Django Commons leans into the GitHub
paradigm and centers the organization as a whole within GitHub. This is a risk, given
there's some vendor lock-in. However, the repositories are still cloned to several people's
machines and the organization controls the keys to PyPI, not GitHub. If something were to occur,
it's manageable.

The second is that Django Commons is built from the beginning to have more than one administrator.
Jazzband has been [working for a while to add additional roadies](https://github.com/jazzband/help/issues/196)
(administrators), but there hasn't been visible progress.  Given the importance of several of
these projects, it's a major risk to the community at large to have a single point of failure
in managing the projects. By being designed from the start to spread the responsibility, it
becomes easier to allow people to step back and others to step up, making Django more sustainable
and the community stronger.

## What is each repository team for?

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

## Who can work on a project?

Anyone can fork any project and work on any issue. All projects within Django Commons are community
maintained. If you're interested in working on a specific project, go get to work!

## Which repository is for what?

- [controls](https://github.com/django-commons/controls): This is for Django Commons administrators
  to manage the GitHub organization. Any issues in this repo are for maintain the magic behind the scenes
- [best-practices](https://github.com/django-commons/best-practices): A sample project with best practices for Django Commons projects.
- [membership](https://github.com/django-commons/membership): The public face for the organization. All issues by members and contributors should be created
  here. **If you're looking for where to ask a question, this is the place for you**
-
### Do we allow all packages or just Django-adjacent?

Any package is welcome to join Django Commons so long as it has tangible benefits to the Django Community at large and the package benefits from being part of Django Commons OR it is about Django Specifically.
