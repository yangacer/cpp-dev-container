# Dockerfile

FROM ubuntu:22.04

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y

# Locales
RUN apt-get install -y --no-install-recommends locales
RUN locale-gen en_US.UTF-8
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

# Install clang and its dependencies
RUN apt-get install -y --no-install-recommends wget
RUN apt-get install -y --no-install-recommends lsb-release
RUN apt-get install -y --no-install-recommends software-properties-common
RUN apt-get install -y --no-install-recommends gnupg
ADD --chmod=755 llvm.sh /usr/bin/
ADD --chmod=755 update-alternatives-clang.sh /usr/bin/
RUN llvm.sh all

# Install cmake and its dependencies
RUN apt-get install -y --no-install-recommends ca-certificates
RUN apt-get install -y --no-install-recommends gpg
RUN test -f /usr/share/doc/kitware-archive-keyring/copyright || wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null | gpg --dearmor - | tee /usr/share/keyrings/kitware-archive-keyring.gpg >/dev/null
RUN echo 'deb [signed-by=/usr/share/keyrings/kitware-archive-keyring.gpg] https://apt.kitware.com/ubuntu/ jammy main' | tee /etc/apt/sources.list.d/kitware.list >/dev/null
RUN apt-get update -y && apt-get install -y --no-install-recommends cmake

# Install other build tools and CI integration tools
RUN apt-get install -y --no-install-recommends ninja-build git

RUN apt-get purge -y software-properties-common
RUN apt-get autoremove -y
RUN apt-get clean

# Bounus configurations
ADD inputrc /root/.inputrc

# ENTRYPOINT [ "/bin/bash" ]
