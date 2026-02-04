# Django Commons mkdocs

The Django Commons docs are deployed at [django-commons.org](https://django-commons.org).

The repository that hosts the docs is at https://github.com/django-commons/django-commons.github.io

## Local Development

1. `cd django-commons.org`
2. Create a Python 3.13 virtual environment (`uv venv --python 3.13`)
3. Run `pip install mkdocs mkdocs-material mkdocs-rss-plugin`
4. Run `mkdocs serve -f mkdocs.yml`

With uv: `uv run --python 3.13 --with mkdocs --with mkdocs-material --with mkdocs-rss-plugin mkdocs serve -f mkdocs.yml`

### pre-commit

You don't have to use pre-commit. But if you choose to:

1. [Install pre-commit](https://pre-commit.com/#installation)
- Run `pre-commit install`

This will install pre-commit. Then, before you commit, run `pre-commit run` to run pre-commit and check your changed files for linting errors.

## Deployment

The site is hosted using GitHub Pages which requires a separate repository.

If you have cloned both this repository and django-commons.github.io to the same parent directory as follows:

```
django-commons-mkdocs/
    django-commons.og/
        mkdocs.yml
    docs/
django-commons.github.io/
```

To deploy, run the following command from the `django-commons.github.io/` directory.

```bash
uv run --python 3.13 --with mkdocs --with mkdocs-material --with mkdocs-rss-plugin mkdocs gh-deploy --config-file ../membership/django-commons.org/mkdocs.yml --remote-branch main
```

## MkDocs Commands

* `mkdocs new [dir-name]` - Create a new project.
* `mkdocs serve` - Start the live-reloading docs server.
* `mkdocs build` - Build the documentation site.
* `mkdocs -h` - Print help message and exit.
