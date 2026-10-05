#!/usr/bin/env bash
# Serves this static site locally for preview (no build step required).
# Caching is disabled so a plain reload always shows the latest edits.
set -euo pipefail
cd "$(dirname "$0")"
PORT="${1:-8000}"
echo "Serving mistvorn-games.github.io at http://localhost:${PORT}/"
python3 - "$PORT" <<'EOF'
import sys
from http.server import SimpleHTTPRequestHandler, ThreadingHTTPServer

class NoCacheHandler(SimpleHTTPRequestHandler):
    def end_headers(self):
        self.send_header("Cache-Control", "no-store")
        super().end_headers()

ThreadingHTTPServer(("", int(sys.argv[1])), NoCacheHandler).serve_forever()
EOF
