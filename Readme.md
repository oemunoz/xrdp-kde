# xrdp kde docker

## Running

Running kde on on docker and loggin it over xrdp.

Flavours available are: `oems/xrdp-kde`

By default it will run a full session with startkde on DISPLAY=:1, you can use Xephyr as an X server window.

```
docker run -it --rm -p 3389:3389 oems/xrdp-kde
```
