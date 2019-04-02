# xrdp kde docker

## Running

Flavours available are: `oems/kde:kde-plasma-desktop`, `oems/kde:kde-standard`, `oems/kde:kde-full`

By default it will run a full session with startkde on DISPLAY=:1, you can use Xephyr as an X server window.

```
docker run -it --rm -p 3389:3389 oems/kde:kde-plasma
```
