#!/bin/bash

# If not D_USER var then setup default as user.
if [ -z ${D_USER+x} ];
then
  echo "user is unset"
  D_USER="default"
fi
# not uid
if [ -z ${U_USER+x} ];
then
  echo "uid is unset"
  U_USER="1000"
fi
# not gui
if [ -z ${G_USER+x} ];
then
  echo "gid is unset"
  G_USER="1000"
fi
# not U_PASS
if [ -z ${D_PASS+x} ];
then
  echo "password is unset: Default password is password"
  D_PASS="password"
fi

# Default user/group, default password is "password"
groupadd --gid "$G_USER" "$D_USER"
D_PASSWORD=$(openssl passwd -1 -salt ADUODeAy $D_PASS)
useradd --uid $U_USER --gid $G_USER --groups video -ms /bin/bash $D_USER && \
    echo "$D_USER:$D_PASSWORD" | chpasswd -e

# Create home diretory
mkdir -p "/home/$D_USER"
chown "$D_USER":"$D_USER" "/home/$D_USER"

# Setup
echo "setting user...."
echo "$D_USER ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/default

# Setting time zone:
#setxkbmap latam
#export TZ="America/Bogota"
#ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install aditional software
#apt-get -y install virt-manager tmux firefox yakuake
