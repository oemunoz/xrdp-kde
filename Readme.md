# xrdp kde docker

## Running

Running kde on on docker and loggin it over xrdp.

Flavours available are: `oems/xrdp-kde`

By default it will run a full session with xrdp on a rdp default port (3389).

```
docker run -it --rm -p 3389:3389 oems/xrdp-kde
```

Using docker-compose:
```yml
version: '3.6'

services:

  xrdp-kde-1:
    image: oems/xrdp-kde
    hostname: xk21
    extra_hosts:
      - "mydns:8.8.8.8"
    environment:
      - D_USER=oemunoz
      - U_USER=1000
      - G_USER=1000
			- D_PASS=mynewpass
    volumes:
      - ./xk21/root:/root
      - ./xk21/home:/home
        #- /home/oemunoz:/home/oemunoz #Use your own home
        #- ./scripts:/scripts
        #- ./xrdp/xrdp.ini:/etc/xrdp/xrdp.ini
        #- ./xrdp/sesman.ini:/etc/xrdp/sesman.ini
        #- ./setup.sh:/setup.sh
        #- ./supervisord.conf:/etc/supervisord.conf
    ports:
      - '3389:3389'
```

You can customize your setup, this is a empty password but you can generate a new one

```bash
# Default user/group, default password is "password"
groupadd --gid "$G_USER" "$D_USER"
D_PASSWORD=$(openssl passwd -1 -salt ADUODeAy $D_PASS)
useradd --uid $U_USER --gid $G_USER --groups video -ms /bin/bash $D_USER && \
    echo "$D_USER:$D_PASSWORD" | chpasswd -e

```

```bash
# Create home diretory
mkdir -p "/home/$D_USER"
chown "$D_USER":"$D_USER" "/home/$D_USER"
```

# Setup
echo "setting user...."
echo "$D_USER ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/default

# Setting time zone:
#setxkbmap latam
#export TZ="America/Bogota"
#ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install aditional software
#apt-get -y install virt-manager tmux firefox yakuake
