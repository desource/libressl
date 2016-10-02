#!/usr/bin/env sh
#
# Download and build libressl
set -euo pipefail

src=$PWD/src
out=$PWD/libressl

# _download "version" "sha256"
_download() {
  mkdir -p ${src}
  curl -OL http://ftp.openbsd.org/pub/OpenBSD/LibreSSL/libressl-${1}.tar.gz
  echo "${2}  libressl-${1}.tar.gz" | sha256sum -c
  tar -C ${src} --strip-components 1 -xf libressl-${1}.tar.gz
}

_build() {
  mkdir -p ${src}/build
  cd ${src}/build
  ../configure --prefix=${out} --disable-shared
  make
  make install
}

_download 2.4.3 bd5726f3e247e7a7d30ce69946d174b8fb92d999d22710c65f176c969812960e
_build
