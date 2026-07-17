#!/usr/bin/env bash
set -ueo pipefail
# shellcheck disable=2034
{
  IMAGE_VER='001'
  SHARED_ASSETS=()
}
stage_shared_assets
_upstream="sources/${TAG}/_shared/upstream"
checkout_upstream 'https://github.com/lbr38/repomanager.git' '5.13.1' "${_upstream}"
# shellcheck disable=2153
[[ -z "${PUSHING:-}" ]] && for _patch in "${IMAGE_DIR}/patches/"*.patch; do
  [[ -f "${_patch}" ]] || continue
  echo "applying ${_patch}"
  patch -d "${_upstream}" -p1 <"${_patch}"
done
# shellcheck disable=2034
BUILD_CONTEXT_DIR="${_upstream}"
# shellcheck disable=2034
PODMAN_EXTRA_ARGS=(--target run)
unset _patch _upstream
