#!/bin/sh
VERSION=2.6.1
apt-get -y install build-essential
wget https://github.com/google/protobuf/releases/download/v$VERSION/protobuf-$VERSION.tar.gz
echo "1...............................PWD=$PWD and ls -l"
ls -l
tar xvfz protobuf-$VERSION.tar.gz
echo "after tar"
ls -l
cd protobuf-$VERSION
echo "2...............................PWD=$PWD and ls -l"
ls -l
./configure --prefix=/usr
echo "3...............................configure"
make install
make
make check
#sudo make install
cd ..
rm protobuf-$VERSION.tar.gz
rm -rf protobuf-$VERSION
