# mistvorn-games.github.io

Public site for [mistvorn.games](https://mistvorn.games) — hosts privacy
policies, terms of service, and other support docs for games published by
Mistvorn Games.

Built by GitHub Pages' Jekyll from the `main` branch. The game pages are
plain HTML that Jekyll copies through untouched; the devlog is Markdown
posts rendered through the layouts in `_layouts/`.

## Structure

- `index.html` — landing page, links out to each game's folder
- `standfast/` — Stand Fast: Survival Arena's page + docs
  - `index.html` — game landing page, links to its docs
  - `privacy-policy.html`, `terms.html`
  - `img/` — banner (`banner.webp` for the page, `banner.png` for social
    previews) and app icon
- `devlog/` — devlog index, plus one filtered index per project in
  `devlog/project/`
- `_posts/` — published devlog posts; `_drafts/` — unpublished ones
- `_layouts/` — page shell (`default`), post page (`post`) and post list
  (`devlog`)
- `_data/projects.yml` — projects a post can be tagged with
- `_config.yml`, `Gemfile` — Jekyll config and local build dependencies
- `assets/style.css` — shared stylesheet (light/dark aware)
- `assets/img/` — studio logo used in the home page hero
- `CNAME` — custom domain config for GitHub Pages (`mistvorn.games`)

## Adding a new game

Each game gets its own folder, named with the last segment of its package
name (e.g. package `games.mistvorn.foo` → folder `foo/`), so the URL is
guessable from the package name. Inside it:

- `index.html` — game landing page, links to that game's docs (copy
  `standfast/index.html` as a starting point)
- `privacy-policy.html`, `terms.html` — same filenames every time, so the
  pattern stays `mistvorn.games/<slug>/privacy-policy.html`

Then add one entry linking to `/<slug>/` from the root `index.html`.

## Devlog visibility

The devlog is currently **hidden**: its pages are committed but not built
on the live site, and nothing links to it. `./serve.sh` still shows it
locally. To launch it:

1. Remove the `published: false` line from `devlog/index.html` and
   `devlog/project/dungeon-crawler.html`.
2. Add `<a href="/devlog/">Devlog</a>` before the Contact link in the nav of
   `index.html` and the three `standfast/*.html` pages.

Posts moved into `_posts/` are built even while the devlog is hidden (their
URLs work, though nothing links to them), so keep them in `_drafts/` until
launch.

## Writing a devlog post

1. Create `_drafts/<slug>.md` with front matter:

   ```yaml
   ---
   title: Post title
   project: dungeon-crawler   # optional; a slug from _data/projects.yml
   ---
   ```

   The first paragraph is used as the summary on the devlog index. Put
   images under `assets/img/devlog/` and reference them by absolute path.
2. Preview it with `./serve.sh` (drafts are shown locally only).
3. To publish, move it to `_posts/YYYY-MM-DD-<slug>.md` and push. It goes
   live at `mistvorn.games/devlog/<slug>/`.

To tag posts with a new project, add it to `_data/projects.yml` and copy
`devlog/project/dungeon-crawler.html` to `devlog/project/<slug>.html`,
updating its `title`, `project` and `permalink`.

## Local preview

Run `./serve.sh` (optionally `./serve.sh <port>`) and open
<http://localhost:8000/>. It needs Ruby with Bundler; gems are installed
into `vendor/bundle` on first run. The site rebuilds and the browser
reloads on every edit (changes to `_config.yml` need a restart).

## Custom domain

DNS for `mistvorn.games` must point at GitHub Pages:

- `A` records (apex) → `185.199.108.153`, `185.199.109.153`,
  `185.199.110.153`, `185.199.111.153`
- `AAAA` records (apex, optional but recommended) → `2606:50c0:8000::153`,
  `2606:50c0:8001::153`, `2606:50c0:8002::153`, `2606:50c0:8003::153`

Once DNS has propagated, enable "Enforce HTTPS" in the repo's Settings →
Pages.
