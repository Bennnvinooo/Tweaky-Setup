#!/bin/bash
# Configure Raspberry Pi as a USB controller

modprobe libcomposite
cd /sys/kernel/config/usb_gadget/
mkdir -p tweaky
cd tweaky

echo 0x1d6b > idVendor
echo 0x0104 > idProduct
echo 0x0100 > bcdDevice
echo 0x0200 > bcdUSB

mkdir -p strings/0x409
echo "0123456789ABCDEF" > strings/0x409/serialnumber
echo "Tweaky" > strings/0x409/manufacturer
echo "Tweaky Mod Adapter" > strings/0x409/product

mkdir -p configs/c.1/strings/0x409
echo "Tweaky Config" > configs/c.1/strings/0x409/configuration
echo 250 > configs/c.1/MaxPower

mkdir -p functions/hid.usb0
echo 1 > functions/hid.usb0/protocol
echo 1 > functions/hid.usb0/subclass
echo 8 > functions/hid.usb0/report_length
echo -ne \\x05\\x01\\x09\\x04\\xa1\\x01\\x05\\x09\\x19\\x01\\x29\\x08\\x15\\x00\\x25\\x01\\x95\\x08\\x75\\x01\\x81\\x02 > functions/hid.usb0/report_desc

ln -s functions/hid.usb0 configs/c.1/
ls /sys/class/udc > UDC


