#!/bin/bash

######## nano ##############################################################
tar xf nano-8.2.tar.xz
cd nano-8.2
./configure --prefix=/usr     \
            --sysconfdir=/etc \
            --enable-utf8     \
            --docdir=/usr/share/doc/nano-8.2 &&
make
make install &&
install -v -m644 doc/{nano.html,sample.nanorc} /usr/share/doc/nano-8.2
cd /root/blfs/text-editor
rm -r nano-8.2
#configure
set autoindent
set constantshow
set fill 72
set historylog
set multibuffer
set nohelp
set positionlog
set quickblank
set regexp
###############################################################################
