# mistvorn-games.github.io

Public site for [mistvorn.games](https://mistvorn.games) — hosts privacy
policies, terms of service, and other support docs for games published by
Mistvorn Games.

Plain static HTML, no build step (`.nojekyll` disables GitHub's Jekyll
processing). Served via GitHub Pages from the `main` branch.

## Structure

- `index.html` — landing page, links out to each game's docs
- `standfast/` — docs for Stand Fast: Survival Arena
- `assets/style.css` — shared stylesheet (light/dark aware)
- `CNAME` — custom domain config for GitHub Pages (`mistvorn.games`)

## Adding a new game's docs

Create a new folder (e.g. `some-game/`), add its `privacy-policy.html` /
`terms.html`, and link to them from `index.html`.

## Custom domain

DNS for `mistvorn.games` must point at GitHub Pages:

- `A` records (apex) → `185.199.108.153`, `185.199.109.153`,
  `185.199.110.153`, `185.199.111.153`
- `AAAA` records (apex, optional but recommended) → `2606:50c0:8000::153`,
  `2606:50c0:8001::153`, `2606:50c0:8002::153`, `2606:50c0:8003::153`

Once DNS has propagated, enable "Enforce HTTPS" in the repo's Settings →
Pages.
