#!/bin/bash

########### unzip #########################
tar xf unzip60.tar.gz
cd unzip60
patch -Np1 -i ../unzip-6.0-consolidated_fixes-1.patch
patch -Np1 -i ../unzip-6.0-gcc14-1.patch
make -f unix/Makefile generic
make prefix=/usr MANDIR=/usr/share/man/man1 \
 -f unix/Makefile install
cd /root/blfs/utility
rm -r unzip60
##################################################