#!/bin/bash

############## dhcpcd #########################
tar xf dhcpcd-10.1.0.tar.xz
cd dhcpcd-10.1.0
./configure --prefix=/usr                \
            --sysconfdir=/etc            \
            --libexecdir=/usr/lib/dhcpcd \
            --dbdir=/var/lib/dhcpcd      \
            --runstatedir=/run           \
            --disable-privsep         &&
make
make install
#configure
make install-service-dhcpcd
cat > /etc/sysconfig/ifconfig.eth0 << "EOF"
ONBOOT="yes"
IFACE="eth0"
SERVICE="dhcpcd"
DHCP_START="-b -q -h $HOSTNAME <insert appropriate start options here>"
DHCP_STOP="-k <insert additional stop options here>"
EOF
cd /root/blfs/network
rm -r dhcpcd-10.1.0
########################################################