#!/usr/bin/env bash
set -ueo pipefail
export IMAGE_VER='000'
mkdir -p "sources/${TAG}/_shared"
_upstream="sources/${TAG}/_shared/upstream"
_pat="${TENGRI_INFRA_READ_PAT:-}"
_repo_url="https://${_pat:+${_pat}@}github.com/TengriDataPlatform/tengri.git"
checkout_upstream "${_repo_url}" master "${_upstream}"
# shellcheck disable=2034
BUILD_CONTEXT_DIR="${_upstream}"
# shellcheck disable=2034
PODMAN_EXTRA_ARGS=(
  --file "${_upstream}/python-env.Dockerfile"
  --target python-env
  --build-arg UID=111
  --build-arg GID=111
  --build-arg PIP_INDEX_URL=https://pypi.org/simple/
)
unset _pat _repo_url _upstream
