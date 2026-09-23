# Django Commons — Hugo site

The Django Commons docs and blog are built with [Hugo](https://gohugo.io/) and deployed at
[django-commons.org](https://django-commons.org).

The built site is published to https://github.com/django-commons/django-commons.github.io.

## Local development

1. [Install Hugo](https://gohugo.io/installation/) (extended version).
2. From this directory, run:

   ```bash
   hugo server -D
   ```

3. Open http://localhost:1313.

All Markdown content lives under [`content/`](content). Templates are in [`layouts/`](layouts),
and the stylesheet/JS/static assets (including the Django Commons logo) are in
[`static/`](static).

### Adding a page

Add a new Markdown file under `content/` with front matter:

```markdown
---
title: "My New Page"
---

Page content here.
```

Then add it to the `menu.main` list in `hugo.toml` if it should appear in the navigation.

### Adding or changing a project

Projects live in [`data/projects.yaml`](data/projects.yaml). Add an entry there and it appears in
the hero ring, the home page directory, and the `/projects/` table. `joined` is optional.

### Adding a blog post

Add a new Markdown file under `content/blog/posts/` with front matter matching the existing
posts (`title`, `date`, `description`, `author`, `categories`, `tags`).

## Deployment

The site is hosted using GitHub Pages, which requires a separate repository
([django-commons/django-commons.github.io](https://github.com/django-commons/django-commons.github.io)).

If you have cloned both this repository and `django-commons.github.io` to the same parent
directory as follows:

```
django-commons.github.io/
membership/
    django-commons.org/
```

To deploy manually, run the following from the `django-commons.org/` directory:

```bash
hugo --gc --minify -d ../../django-commons.github.io
cd ../../django-commons.github.io
git add -A
git commit -m "Deploy $(git -C ../membership rev-parse --short HEAD)"
git push origin gh-pages
```

Alternatively, pushes to `main` in this repository trigger the
`.github/workflows/deploy-site.yml` workflow, which builds the site with Hugo and pushes the
result to the `gh-pages` branch of `django-commons.github.io` automatically. That workflow
needs a `PAGES_DEPLOY_TOKEN` repository secret — a GitHub personal access token (fine-grained,
`contents: write` on the `django-commons.github.io` repo only) — configured before it will work.
