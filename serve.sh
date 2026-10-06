#!/usr/bin/env bash
# Builds and serves the site locally with Jekyll, rebuilding on change.
# Drafts and pages marked `published: false` are included so they can be
# previewed before going live.
set -euo pipefail
cd "$(dirname "$0")"
PORT="${1:-8000}"
bundle config set --local path vendor/bundle
bundle install --quiet
bundle exec jekyll serve --drafts --unpublished --livereload --port "$PORT"
