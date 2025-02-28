#!/bin/bash
# Tweaky Installation Script

echo "🔄 Updating System..."
sudo apt update && sudo apt upgrade -y

echo "⚙ Enabling USB Gadget Mode..."
sudo sed -i 's/$/ modules-load=dwc2,g_serial/' /boot/firmware/cmdline.txt
echo -e "\ndtoverlay=dwc2\nenable_uart=1" | sudo tee -a /boot/firmware/config.txt

echo "📦 Installing Dependencies..."
sudo apt install -y python3-pip lua5.3 nodejs bluetooth bluez bluez-tools git

echo "🔌 Setting up USB Gadget Mode..."
sudo bash /home/pi/Tweaky-Setup/usb-gadget.sh

echo "✅ Installation complete! Rebooting..."
sudo reboot
