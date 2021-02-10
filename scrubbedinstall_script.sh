#!/bin/bash

#Mount the pi server persistently
mkdir /mnt/media
echo "//192.168.0.100/media /mnt/media cifs defaults,user=<username>,pass=<password>,rw 0 0" >> /etc/fstab
mount -a

#Run update before installing software
apt-get update

#Install useful software with apt
apt-get -y install at vim dconf-cli git clementine htop remmina python3-pip chromium openssh-server
#Clone preferred terminal theme
git clone https://github.com/dracula/gnome-terminal
#Install .deb packages kept on pi server
dpkg -i /mnt/media/software/Mullvad*
dpkg -i /mnt/media/software/code*
dpkg -i /mnt/media/software/virtualbox*

#Create a backup of the original .bashrc, then extract my archived .bashrc and aliases here
mv .bashrc .bashrc_backup
tar xzf /mnt/media/backup/bashrc_and_aliases.tar.gz

#Run -f as virtualbox doesn't install properly without dependencies fixed, then upgrade
apt-get install -f -y
apt-get -y upgrade

reboot now
