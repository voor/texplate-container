FROM debian

ENV TEXPLATE_VERSION    latest
ENV GOMPLATE_VERSION    latest

RUN apt-get update && apt-get install -y \
    apt-transport-https \
    ca-certificates \
    unzip \
    curl \
    jq \
    && curl -sSL -o /usr/bin/texplate $(curl -sSL https://api.github.com/repos/pivotal-cf/texplate/releases/${TEXPLATE_VERSION} | jq -r -c ".assets[] | .browser_download_url" | grep linux) \
    && chmod +x /usr/bin/texplate \
    && curl -sSL -o /usr/bin/gomplate $(curl -sSL https://api.github.com/repos/hairyhenderson/gomplate/releases/${GOMPLATE_VERSION} | jq -r -c ".assets[] | .browser_download_url" | grep linux-amd64) \
    && chmod +x /usr/bin/gomplate \
    && apt-get purge --auto-remove -y curl gnupg unzip \
    && rm -rf /var/lib/apt/lists/* \
    && gomplate -v
