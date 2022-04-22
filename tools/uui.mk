#!/bin/bash -e

script_in=${soc}/bootscript
bootloader=${soc}/bootloader
script=boot.scr
seek=${seek:-1}

mkimage -A arm -O linux -T script -C none -a 0 -e 0 -n bootscr -d ${script_in} ${script}

image=$(mktemp --dry-run --quiet)
size=16

dd if=/dev/zero of=${image} bs=1M count=${size}

sudo sfdisk --force -uS ${image} << eosfdisk
8194,,0x83
eosfdisk

device=$(sudo losetup --find --show ${image})
sudo partprobe ${device}
sudo mkfs.ext2 -L uui ${device}p1

mnt_point=$(mktemp --dry-run)
mkdir -p ${mnt_point}
sudo mount ${device}p1 ${mnt_point}

echo "Processing fs-copy ... "
sudo cp -v ${bootloader} ${script} ${mnt_point}

echo "Processing raw-copy ... "
sudo dd if=${bootloader} of=${device} bs=1K seek=${seek}
echo "raw-copy [ OK ]"

sudo umount ${device}p1
sudo rm -rf  ${mnt_point} ${script}

sudo losetup -d ${device}
mv ${image} /tmp/uui.$(date +%s)
ln -sf /tmp/uui.$(date +%s) uui.img
