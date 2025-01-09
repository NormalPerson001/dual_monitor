sudo apt install linux-headers-$(uname -r) -y && sudo apt install nvidia-drivers nvidia-xconfig -y && sudo update-initramfs -u 
mv display_vidia.sh ~/.local/bin/
