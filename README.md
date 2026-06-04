# Container images collection

[![containers](https://github.com/TengriDataPlatform/container-images/actions/workflows/containers.yaml/badge.svg)](https://github.com/TengriDataPlatform/container-images/actions/workflows/containers.yaml)

## Before manual `./push.sh`

```shell
podman login --username json_key --password-stdin ghcr.io
```

## Build steps

- clone me:

  ```bash
  git clone --recursive git@github.com:TengriDataPlatform/container-images && cd container-images
  ```

- build some container image(s):

  ```bash
  MANUAL_IMAGES_DIRS='opencode-ubuntu-22_04/ utils-ubuntu-22_04/' _shared/_all/build.sh
  ```

- push some container image(s):

  ```bash
  MANUAL_IMAGES_DIRS='opencode-ubuntu-22_04/ utils-ubuntu-22_04/' _shared/_all/push.sh
  ```
