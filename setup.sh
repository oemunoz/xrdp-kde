#!/bin/bash
D_USER="default"

# Setup  
echo "setting user...."
echo 'default ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers.d/default
