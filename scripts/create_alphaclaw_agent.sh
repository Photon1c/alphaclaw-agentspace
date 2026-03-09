#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PATCH_FILE="${ROOT_DIR}/patches/alphaclaw-whatsapp-onboarding.patch"
TARGET_DIR="${1:-${ROOT_DIR}/alphaclaw-agent}"
UPSTREAM_URL="https://github.com/chrysb/alphaclaw.git"

if [[ ! -f "${PATCH_FILE}" ]]; then
  echo "Patch file not found: ${PATCH_FILE}" >&2
  exit 1
fi

if [[ -d "${TARGET_DIR}/.git" ]]; then
  echo "Using existing clone at ${TARGET_DIR}"
else
  echo "Cloning ${UPSTREAM_URL} into ${TARGET_DIR}"
  git clone "${UPSTREAM_URL}" "${TARGET_DIR}"
fi

echo "Checking whether patch can be applied..."
if git -C "${TARGET_DIR}" apply --check "${PATCH_FILE}" >/dev/null 2>&1; then
  git -C "${TARGET_DIR}" apply "${PATCH_FILE}"
  echo "Patch applied."
else
  if git -C "${TARGET_DIR}" apply --reverse --check "${PATCH_FILE}" >/dev/null 2>&1; then
    echo "Patch already applied."
  else
    echo "Patch does not apply cleanly. Ensure the clone is on a compatible upstream revision." >&2
    exit 2
  fi
fi

echo ""
echo "AlphaClaw agent source is ready at: ${TARGET_DIR}"
echo "Recommended next steps:"
echo "  cd \"${TARGET_DIR}\""
echo "  npm install"
echo "  npm test -- --run tests/frontend/pairing-utils.test.js tests/server/onboarding-openclaw.test.js tests/server/routes-onboarding.test.js tests/server/routes-pairings.test.js tests/server/secret-detector.test.js"
