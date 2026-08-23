#!/usr/bin/env bash
# Serves this static site locally for preview (no build step required).
set -euo pipefail
cd "$(dirname "$0")"
PORT="${1:-8000}"
echo "Serving mistvorn-games.github.io at http://localhost:${PORT}/"
python3 -m http.server "$PORT"
