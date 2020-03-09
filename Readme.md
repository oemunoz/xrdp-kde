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
      - D_USER=kdeuser
      - U_USER=1000
      - G_USER=1000
      - D_PASS=mynewpass
    volumes:
      - ./xk21/root:/root
      - ./xk21/home:/home
        #- /home/kdeuser/home/kdeuser #Use your own home
        #- ./scripts:/scripts
        #- ./xrdp/xrdp.ini:/etc/xrdp/xrdp.ini
        #- ./xrdp/sesman.ini:/etc/xrdp/sesman.ini
        #- ./setup.sh:/setup.sh
        #- ./supervisord.conf:/etc/supervisord.conf
    ports:
      - '3389:3389'
```

You can customize your setup, you can change: 
- User name (replace kdeuser)
- Change default password (default is a empty password or change it using docker exec and user root into the container)

For example:
```bash
docker exec -it xrdp-kde_xrdp-kde-1_1 passwd kdeuser
Enter new UNIX password: 
Retype new UNIX password: 
passwd: password updated successfully
```

If want to setup some extra features, you can un-comment the line setup.sh on volumes section:

```yaml
    volumes:
      - ./xk21/root:/root
      - ./xk21/home:/home
        #- /home/oemunoz:/home/oemunoz #Use your own home
        #- ./scripts:/scripts
        #- ./xrdp/xrdp.ini:/etc/xrdp/xrdp.ini
        #- ./xrdp/sesman.ini:/etc/xrdp/sesman.ini
        - ./setup.sh:/setup.sh
        #- ./supervisord.conf:/etc/supervisord.conf 
```
and then edit the setup.sh file, for example:

```bash
# Setup
echo "setting user...."
echo "$D_USER ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/default

# Setting time zone:
setxkbmap latam
export TZ="America/Bogota"
ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install aditional software
apt-get -y install virt-manager tmux firefox yakuake
```
