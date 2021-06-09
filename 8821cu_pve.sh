#!/bin/sh

# switch usb mode
./usb_modeswitch -KW -v 0bda -p 1a2b

read -p "Press ENTER to continue" enter_pressed

# install driver

mkdir -p /lib/modules/$(uname -r)/kernel/drivers/net/wireless/realtek/rtl8821cu/
install -p -m 644 8821cu.ko /lib/modules/$(uname -r)/kernel/drivers/net/wireless/realtek/rtl8821cu/
depmod -a $(uname -r)


# rm -rfv $(MODDESTDIR)
#	/sbin/depmod -a ${KVER}

echo 'network={
	ssid="YOUR_WIFI_SSID"
	psk="YOUR_WIFI_PASSWORD"
}' > /etc/wpa_sup.conf


cp /etc/network/interfaces /etc/network/interfaces.bak

echo 'auto lo
iface lo inet loopback

allow-hotplug wlan0
auto wlan0
iface wlan0 inet dhcp
        wpa-conf /etc/wpa_sup.conf

iface ens33 inet manual

auto vmbr0
iface vmbr0 inet static
        address 192.168.1.100/24
        gateway 192.168.1.1
        bridge_ports wlan0
        bridge_stp off
        bridge_fd 0' > /etc/network/interfaces


./iwconfig
read -p "Press ENTER to continue" enter_pressed

./wpa_supplicant -B -i wlan0 -c /etc/wpa_sup.conf

/etc/init.d/networking restart

