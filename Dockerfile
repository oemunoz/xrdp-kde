FROM ubuntu:18.04
MAINTAINER Oscar Munoz <oscaremu@gmail.com>

RUN echo 'Acquire::http::Proxy "http://proxysquiddeb:8000/";' >> /etc/apt/apt.conf

RUN apt-get update && \
    apt-get dist-upgrade -y && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y gnupg2 ubuntu-minimal ubuntu-standard

# Added kde 
RUN apt-get install -y kde-plasma-desktop
#RUN apt-get install -y kde-standard
#RUN apt-get install -y kde-full

# Added xrdp service. 
RUN apt-get -y install xrdp supervisor supervisor-doc xrdp-pulseaudio-installer

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
RUN /sbin/setcap -r /usr/lib/*/libexec/kf5/start_kdeinit

# Default user, blank password 
RUN useradd -G video -ms /bin/bash default && \
    echo 'default:U6aMy0wojraho' | chpasswd -e && \
    chmod +x /setup.sh

ENV DISPLAY=:1
ENV KDE_FULL_SESSION=true
ENV SHELL=/bin/bash

ENV XDG_RUNTIME_DIR=/run/neon

RUN echo '' > /etc/apt/apt.conf
USER root
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]
