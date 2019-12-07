FROM ubuntu:18.04
MAINTAINER Oscar Munoz <oscaremu@gmail.com>

RUN apt-get update && \
    apt-get dist-upgrade -y && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y ubuntu-minimal ubuntu-standard

# Added kde 
RUN apt-get install -y kde-plasma-desktop
#RUN apt-get install -y kde-standard
#RUN apt-get install -y kde-full

# Added xrdp service. 
RUN apt-get -y install gnupg xrdp supervisor supervisor-doc xrdp-pulseaudio-installer

# Refresh apt cache once more now that appstream is installed 
RUN rm -r /var/lib/apt/lists/* && \
    apt-get update && apt-get dist-upgrade -y && \
    apt-get clean

# Added DBus
RUN mkdir -p /var/run/dbus
RUN chown messagebus:messagebus /var/run/dbus
RUN dbus-uuidgen --ensure

ADD supervisord.conf /etc/supervisord.conf
ADD setup.sh         /setup.sh

# remove setcap from kinit which Docker seems not to like \
RUN chmod +x /setup.sh && \
	  /sbin/setcap -r /usr/lib/*/libexec/kf5/start_kdeinit

ENV DISPLAY=:1
ENV KDE_FULL_SESSION=true
ENV SHELL=/bin/bash

ENV XDG_RUNTIME_DIR=/run/neon

USER root
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]
