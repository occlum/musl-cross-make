#!/bin/sh
cp config.mak.occlum config.mak
mkdir sources; cd sources

git clone https://github.com/occlum/musl musl-1.1.20

tar -czvf musl-1.1.20.tar.gz musl-1.1.20
rm musl-1.1.20 -rf

cd ../

make -j
make install -j
