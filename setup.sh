#!/bin/bash

# If not D_USER var then setup default as user.
if [ -z ${D_USER+x} ]; 
then 
	echo "var is unset"
  D_USER="default"
fi
# not uid
if [ -z ${U_USER+x} ]; 
then 
	echo "var is unset"
  U_USER="1000"
fi
# not gui
if [ -z ${G_USER+x} ]; 
then 
	echo "var is unset"
	G_USER="1000"
fi

# Default user/group, blank password 
groupadd --gid 1000 oemunoz
useradd --uid $U_USER --gid $G_USER --groups video -ms /bin/bash $D_USER && \
    echo "$D_USER:U6aMy0wojraho" | chpasswd -e 

# Create home diretory
mkdir -p "/home/$D_USER"
chown "$D_USER:$D_USER /home/$D_USER"

# Setup  
echo "setting user...."
echo "$D_USER ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/default
