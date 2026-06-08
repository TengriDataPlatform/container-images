#!/bin/sh
# cspell:ignore ipykernel tngri
set -eu
mkdir -p /home/python/packages
pip wheel --no-deps -w /home/python/packages \
  git+https://github.com/TengriDataPlatform/tngri_client.git
pip download -d /home/python/packages --find-links /home/python/packages ipykernel tngri
mkdir -p /home/python
chmod 1777 /tmp
chmod 1777 /home/python
# cleanup
rm -Rf /usr/share/doc /usr/share/man /var/lib/apt/lists/* /root/.cache/pip /files
