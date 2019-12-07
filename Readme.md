# xrdp kde docker

## Running

Running kde on on docker and loggin it over xrdp.

Flavours available are: `oems/xrdp-kde`

By default it will run a full session with startkde on DISPLAY=:1, you can use Xephyr as an X server window.

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
    volumes:
      - ./xk21/root:/root
      - ./xk21/home:/home
        #- ./scripts:/scripts
        #- ./xrdp/xrdp.ini:/etc/xrdp/xrdp.ini
        #- ./xrdp/sesman.ini:/etc/xrdp/sesman.ini
        #- ./setup.sh:/setup.sh
        #- ./supervisord.conf:/etc/supervisord.conf
    ports:
      '3389:3389
