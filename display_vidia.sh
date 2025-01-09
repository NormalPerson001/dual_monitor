#!/bin/bash

# Check if an argument is passed
if [ $# -eq 0 ]; then
    echo "Usage: $0 <on|off>"
    exit 1
fi

# Get the first argument
arg=$1

# Check the value of the argument
if [ "$arg" == "on" ]; then

echo "Turning on the second display display NOTE: This will turn on the second display when rebooted"

sudo echo "blacklist nouveau
options nouveau modeset=0" > /etc/modprobe.d/blacklist-nouveau.conf

sudo modprobe nvidia-drm

nvidia-xconfig --query-gpu-info
 Similar --> PCI BusID: PCI:1:0:0

sudo echo 'Section "ServerLayout"
        Identifier "layout"
        Screen 0 "nvidia"
        Inactive "intel"
EndSection
 
Section "Device"
        Identifier "nvidia"
        Driver "nvidia"
        BusID "PCI:1:0:0"
EndSection
 
Section "Screen"
        Identifier "nvidia"
        Device "nvidia"
        Option "AllowEmptyInitialConfiguration"
EndSection
 
Section "Device"
        Identifier "intel"
        Driver "modesetting"
EndSection
 
Section "Screen"
        Identifier "intel"
        Device "intel"
EndSection

' > /etc/X11/xorg.conf.d/xorg.conf

sudo echo '
[Desktop Entry]
Type=Application
Name=Optimus
Exec=sh -c "xrandr --setprovideroutputsource modesetting NVIDIA-0; xrandr --auto"
NoDisplay=true
X-GNOME-Autostart-Phase=DisplayServer' > /etc/xdg/autostart/optimus.desktop 


sudo echo '
[Desktop Entry] 
Type=Application
Name=Optimus
Exec=sh -c "xrandr --setprovideroutputsource modesetting NVIDIA-0; xrandr --auto"
NoDisplay=true
X-GNOME-Autostart-Phase=DisplayServer' > /usr/share/gdm/greeter/autostart/optimus.desktop

echo "Done!, Please reboot your system"

elif [ "$arg" == "off" ]; then

echo "Turning on the main display NOTE: This will turn off the second display when rebooted"

sudo rm /etc/modprobe.d/blacklist-nouveau.conf

sudo rm /etc/X11/xorg.conf.d/xorg.conf

sudo rm /usr/share/gdm/greeter/autostart/optimus.desktop

sudo rm /etc/xdg/autostart/optimus.desktop

echo "Done!, Please reboot your system"

else
    echo "Invalid argument. Please use 'on' or 'off'."
    exit 1
fi
