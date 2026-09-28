#!/usr/bin/env bash
set -ueo pipefail
# shellcheck disable=1091
MY_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=/dev/null
source "${MY_PATH}/vars.sh"
DIR_SON='['
# shellcheck disable=2153
for dir in "${IMAGES_DIRS[@]}"; do
  DIR_SON="${DIR_SON}\"${dir//sources\//}\","
done
export DIR_SON="${DIR_SON%,}]"
