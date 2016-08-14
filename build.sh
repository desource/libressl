#!/usr/bin/env sh
set -eux

LIBRESSL_VERSION=2.4.2
LIBRESSL_SHA512=abacecb318a787f5ef9d8469638b7485fe237d4d993f410d7da8c0773ab8eff8c7da988fe965f793b268711afe599dc28f994eedeaa2aafebeb40faa30af38db

SRC=$PWD/src
OUT=$PWD/libressl

mkdir -p $SRC
curl -OL http://ftp.openbsd.org/pub/OpenBSD/LibreSSL/libressl-$LIBRESSL_VERSION.tar.gz
echo "$LIBRESSL_SHA512  libressl-$LIBRESSL_VERSION.tar.gz" | sha512sum -c
tar -C $SRC --strip-components 1 -xf libressl-$LIBRESSL_VERSION.tar.gz

mkdir -p $SRC/build
cd $SRC/build
../configure --prefix=$OUT --disable-shared
make
make install
