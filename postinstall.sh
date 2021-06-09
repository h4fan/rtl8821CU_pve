#!/bin/sh

# rm -rfv $(MODDESTDIR)
#	/sbin/depmod -a ${KVER}

# replace apt source

sed -i 's/deb/#deb/g' /etc/apt/sources.list.d/pve-enterprise.list

echo 'deb https://mirrors.tuna.tsinghua.edu.cn/proxmox/debian buster pve-no-subscription' >> /etc/apt/sources.list.d/pve-no-subscription.list

cp /etc/apt/sources.list /etc/apt/sources.list.bak

echo "deb https://mirrors.tuna.tsinghua.edu.cn/debian/ buster main contrib non-free" > /etc/apt/sources.list
# deb-src https://mirrors.tuna.tsinghua.edu.cn/debian/ buster main contrib non-free
echo "deb https://mirrors.tuna.tsinghua.edu.cn/debian/ buster-updates main contrib non-free"  >> /etc/apt/sources.list
# deb-src https://mirrors.tuna.tsinghua.edu.cn/debian/ buster-updates main contrib non-free
echo "deb https://mirrors.tuna.tsinghua.edu.cn/debian/ buster-backports main contrib non-free" >> /etc/apt/sources.list
# deb-src https://mirrors.tuna.tsinghua.edu.cn/debian/ buster-backports main contrib non-free
echo "deb https://mirrors.tuna.tsinghua.edu.cn/debian-security buster/updates main contrib non-free" >> /etc/apt/sources.list
# deb-src https://mirrors.tuna.tsinghua.edu.cn/debian-security buster/updates main contrib non-free

sed -i "s/mirrors.tuna.tsinghua.edu.cn/mirrors.ustc.edu.cn/g" /etc/apt/sources.list
sed -i "s/mirrors.tuna.tsinghua.edu.cn/mirrors.ustc.edu.cn/g" /etc/apt/sources.list.d/pve-no-subscription.list

apt update

apt -y install usb-modeswitch wireless-tools make gcc git dkms pve-headers-$(uname -r) wpasupplicant pve-headers

git clone https://github.com/brektrou/rtl8821CU.git



