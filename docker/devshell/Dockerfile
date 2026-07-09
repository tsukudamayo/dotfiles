FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Tokyo

RUN apt-get update && apt-get install -y \
        ca-certificates \
        curl \
        wget \
        gnupg \
        lsb-release \
        apt-transport-https \
        software-properties-common \
        git \
        vim \
        neovim \
        tmux \
        zsh \
        jq \
        unzip \
        less \
        tree \
        ripgrep \
        fd-find \
        fzf \
        python3 \
        python3-pip \
        python3-venv \
        make \
        build-essential \
        openssh-client \
        sudo \
        && rm -rf /var/lib/apt/lists/*

# Google Cloud CLI
RUN curl https://packages.cloud.google.com/apt/doc/apt-key.gpg \
        | gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg \
        && echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" \
        > /etc/apt/sources.list.d/google-cloud-sdk.list \
        && apt-get update \
        && apt-get install -y \
        google-cloud-cli \
        google-cloud-cli-gke-gcloud-auth-plugin \
        kubectl \
        && rm -rf /var/lib/apt/lists/*

# yq
RUN set -eux; \
        ARCH="$(dpkg --print-architecture)"; \
        case "$ARCH" in \
          amd64) YQ_ARCH="amd64" ;; \
          arm64) YQ_ARCH="arm64" ;; \
          *) echo "unsupported arch: $ARCH" && exit 1 ;; \
        esac; \
        wget -qO /usr/local/bin/yq \
          "https://github.com/mikefarah/yq/releases/latest/download/yq_linux_${YQ_ARCH}"; \
        chmod +x /usr/local/bin/yq

# GitHub CLI
RUN mkdir -p -m 755 /etc/apt/keyrings \
        && wget -qO- https://cli.github.com/packages/githubcli-archive-keyring.gpg \
        | tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
        && chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
        && echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" \
        > /etc/apt/sources.list.d/github-cli.list \
        && apt-get update \
        && apt-get install -y gh \
        && rm -rf /var/lib/apt/lists/*

# Git default config
RUN git config --global init.defaultBranch main

WORKDIR /workspace

CMD ["zsh"]
