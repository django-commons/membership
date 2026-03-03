# Django Commons mkdocs

The Django Commons docs are deployed at [django-commons.org](https://django-commons.org).

The repository that hosts the docs is at https://github.com/django-commons/django-commons.github.io

## Local Development

1. `cd django-commons.org`
2. Create a Python 3.13 virtual environment (`uv venv --python 3.13`)
3. Run `uv pip install mkdocs mkdocs-material mkdocs-rss-plugin`
4. Run `uv run mkdocs serve -f mkdocs.yml`

### pre-commit

You don't have to use pre-commit. But if you choose to:

1. [Install pre-commit](https://pre-commit.com/#installation)
- Run `pre-commit install`

This will install pre-commit. Then, before you commit, run `pre-commit run` to run pre-commit and check your changed files for linting errors.

## Deployment

The site is hosted using GitHub Pages which requires a separate repository.

If you have cloned both this repository and django-commons.github.io to the same parent directory as follows:

```
membership/
    django-commons.og/
        mkdocs.yml
    docs/
```

To deploy, run the following command from the `membership` repository root directory.

```bash
uv run mkdocs gh-deploy --config-file ./django-commons.org/mkdocs.yml --remote-branch main
```

## MkDocs Commands

* `mkdocs new [dir-name]` - Create a new project.
* `mkdocs serve` - Start the live-reloading docs server.
* `mkdocs build` - Build the documentation site.
* `mkdocs -h` - Print help message and exit.
