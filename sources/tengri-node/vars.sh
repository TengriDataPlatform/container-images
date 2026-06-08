#!/usr/bin/env bash
set -ueo pipefail
export IMAGE_VER='001'
mkdir -p "sources/${TAG}/_shared"
_upstream="sources/${TAG}/_shared/upstream"
_pat="${TENGRI_INFRA_READ_PAT:-}"
_repo_url="https://${_pat:+${_pat}@}github.com/TengriDataPlatform/tengri.git"
checkout_upstream "${_repo_url}" master "${_upstream}"
_dockerfile="${_upstream}/node-env.Dockerfile"
# shellcheck disable=2153
for _patch in "${IMAGE_DIR}/patches/"*.patch; do
  [[ -f "${_patch}" ]] || continue
  echo "applying ${_patch}"
  if ! patch -d "${_upstream}" -p1 <"${_patch}"; then
    if grep -q 'node-env\.Dockerfile' "${_patch}"; then
      echo "patch failed on node-env.Dockerfile, replacing from files/"
      cp "${IMAGE_DIR}/files/Dockerfile" "${_dockerfile}"
    else
      exit 1
    fi
  fi
done
# shellcheck disable=2034
BUILD_CONTEXT_DIR="${_upstream}"
# shellcheck disable=2034
PODMAN_EXTRA_ARGS=(
  --file "${_upstream}/node-env.Dockerfile"
  --target node-env
)
unset _pat _repo_url _upstream _patch
