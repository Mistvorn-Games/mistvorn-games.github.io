# mistvorn-games.github.io

Public site for [mistvorn.games](https://mistvorn.games) — hosts privacy
policies, terms of service, and other support docs for games published by
Mistvorn Games.

Plain static HTML, no build step (`.nojekyll` disables GitHub's Jekyll
processing). Served via GitHub Pages from the `main` branch.

## Structure

- `index.html` — landing page, links out to each game's folder
- `standfast/` — Stand Fast: Survival Arena's page + docs
  - `index.html` — game landing page, links to its docs
  - `privacy-policy.html`, `terms.html`
- `assets/style.css` — shared stylesheet (light/dark aware)
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

## Custom domain

DNS for `mistvorn.games` must point at GitHub Pages:

- `A` records (apex) → `185.199.108.153`, `185.199.109.153`,
  `185.199.110.153`, `185.199.111.153`
- `AAAA` records (apex, optional but recommended) → `2606:50c0:8000::153`,
  `2606:50c0:8001::153`, `2606:50c0:8002::153`, `2606:50c0:8003::153`

Once DNS has propagated, enable "Enforce HTTPS" in the repo's Settings →
Pages.
