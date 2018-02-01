FROM debian:stretch
MAINTAINER jono <jono@bowerswilkins.com>

ARG DEBIAN_FRONTEND=noninteractive

RUN set -eux &&\
    apt-get update &&\
    apt-get upgrade -y &&\
    apt-get install -yq \
        apt-utils bash bc build-essential chrpath cpio curl debianutils diffstat doxygen \
        gawk gcc-multilib git git-core libc6-dev-i386 libmsgpack-dev libncurses5-dev locales lzop man python python3 \
        python3-pexpect python3-pip quilt screen socat sudo texinfo unzip vim wget xz-utils &&\
    rm -rf /var/lib/apt-lists/* &&\
    echo "dash dash/sh boolean false" | debconf-set-selections &&\
    dpkg-reconfigure dash &&\
    useradd -ms /bin/bash -p build build && \
    usermod -aG sudo build &&\
    echo "build ALL=(ALL) NOPASSWD: ALL" | tee -a /etc/sudoers &&\
    echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && locale-gen &&\
    curl http://storage.googleapis.com/git-repo-downloads/repo > /usr/local/bin/repo &&\
    chmod a+x /usr/local/bin/repo

ENV LANG en_US.utf8

USER build
WORKDIR /src

CMD [ "/bin/bash" ]
