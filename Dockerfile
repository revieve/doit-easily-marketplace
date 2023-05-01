FROM ubuntu:22.04

RUN apt-get update && apt-get install -y \
        bash-completion \
        lsb-release \
        make \
        curl \
        unzip \
        jq \
        apt-transport-https \
        ca-certificates \
        gnupg \
        less

RUN echo ". /etc/bash_completion" >> /root/.bashrc

# terraform
RUN curl https://apt.releases.hashicorp.com/gpg | apt-key --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg add -
RUN echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/hashicorp.list
RUN apt-get update && apt-get install -y terraform

# gcloud cli
# Add the repository
RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
# Add the key
RUN curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
# Install the cli
RUN apt-get update && apt-get install -y google-cloud-cli

RUN mkdir -p /root/ops

WORKDIR /root/ops
