#!/bin/bash

######################################################### recommended pkg

############## libnl##################
tar xf libnl-3.11.0.tar.gz
cd libnl-3.11.0
./configure --prefix=/usr     \
            --sysconfdir=/etc \
            --disable-static  &&
make
make install
cd /root/blfs/network/wpa_supplicant
rm -r libnl-3.11.0
##############################################

########################################################################

##################### wpa supplicant #########################
tar xf wpa_supplicant-2.11.tar.gz
cd wpa_supplicant-2.11
cat > wpa_supplicant/.config << "EOF"
CONFIG_BACKEND=file
CONFIG_CTRL_IFACE=y
CONFIG_DEBUG_FILE=y
CONFIG_DEBUG_SYSLOG=y
CONFIG_DEBUG_SYSLOG_FACILITY=LOG_DAEMON
CONFIG_DRIVER_NL80211=y
CONFIG_DRIVER_WEXT=y
CONFIG_DRIVER_WIRED=y
CONFIG_EAP_GTC=y
CONFIG_EAP_LEAP=y
CONFIG_EAP_MD5=y
CONFIG_EAP_MSCHAPV2=y
CONFIG_EAP_OTP=y
CONFIG_EAP_PEAP=y
CONFIG_EAP_TLS=y
CONFIG_EAP_TTLS=y
CONFIG_IEEE8021X_EAPOL=y
CONFIG_IPV6=y
CONFIG_LIBNL32=y
CONFIG_PEERKEY=y
CONFIG_PKCS12=y
CONFIG_READLINE=y
CONFIG_SMARTCARD=y
CONFIG_WPS=y
CFLAGS += -I/usr/include/libnl3
EOF
cd wpa_supplicant &&
make BINDIR=/usr/sbin LIBDIR=/usr/lib
install -v -m755 wpa_{cli,passphrase,supplicant} /usr/sbin/ &&
install -v -m644 doc/docbook/wpa_supplicant.conf.5 /usr/share/man/man5/ &&
install -v -m644 doc/docbook/wpa_{cli,passphrase,supplicant}.8 /usr/share/man/man8/
cd blfs/network/wpa_supplicant
rm -r /root/wpa_supplicant-2.11
############################################################################