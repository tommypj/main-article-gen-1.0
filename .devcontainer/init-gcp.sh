#!/usr/bin/env bash
set -euo pipefail

# Install Firebase CLI if missing
if ! command -v firebase >/dev/null 2>&1; then
  npm i -g firebase-tools
fi

# Auto auth if secret is set
if [[ -n "${GCP_SA_KEY:-}" ]]; then
  echo "$GCP_SA_KEY" > /workspaces/sa-key.json
  gcloud auth activate-service-account --key-file=/workspaces/sa-key.json
  [[ -n "${GCP_PROJECT_ID:-}" ]] && gcloud config set project "$GCP_PROJECT_ID"
else
  echo "Tip: run 'gcloud auth login --no-launch-browser' and 'firebase login --no-localhost' to auth interactively."
fi
