# cspell:ignore libltdl libkrb libkrb libgssapi
FROM python:3.13-slim AS python-env
ARG PIP_INDEX_URL=https://mirrors.aliyun.com/pypi/simple/
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
  --no-install-recommends gcc g++ git ssh libltdl7 libkrb5-3 libgssapi-krb5-2 && rm \
  -rf /var/lib/apt/lists/*
COPY files/ /files/
RUN /files/install.sh
RUN pip install --no-cache-dir --index-url "$PIP_INDEX_URL" python-lsp-server==1.12.2

# Pre-bakes the e2e shared venv at its *runtime* path so shebangs stay
# self-referential when venv-prewarm copies it into the agent cache volume.
# Production builds must stop at `python-env` via `--target python-env`.
FROM python-env AS e2e-venv-prewarm
USER root
COPY docker/seed-venv.sh /usr/local/bin/seed-venv
RUN chmod +x /usr/local/bin/seed-venv
USER python
RUN seed-venv build
