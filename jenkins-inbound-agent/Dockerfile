FROM jenkins/inbound-agent:latest
USER root
RUN sed -i 's/deb.debian.org/mirrors.cloud.tencent.com/g' /etc/apt/sources.list \
    && apt-get update -qq \
    && apt-get -y install curl wget unzip \
    && sed -i 's/TLSv1.2/TLSv1.0/g' /etc/ssl/openssl.cnf \
    && apt-get clean \
    && rm -rf /tmp/* \
    && rm -rf /var/lib/apt/lists/*
USER 1000