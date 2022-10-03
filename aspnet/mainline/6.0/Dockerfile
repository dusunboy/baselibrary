FROM mcr.microsoft.com/dotnet/aspnet:6.0
RUN sed -i 's/deb.debian.org/mirrors.xjtu.edu.cn/g' /etc/apt/sources.list \
    && apt-get update -qq \
    && apt-get -y install curl telnet \
    && addgroup --system --gid 1000 appuser \
    && adduser --system --home /home/appuser --shell /bin/bash --uid 1000 --gid 1000 --disabled-password appuser \
    && sed -i 's/TLSv1.2/TLSv1.0/g' /etc/ssl/openssl.cnf \
    && apt-get clean \
    && rm -rf  /tmp/* \
    && rm -rf /var/lib/apt/lists/*
