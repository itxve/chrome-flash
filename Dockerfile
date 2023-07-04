FROM ghcr.io/linuxserver/baseimage-kasmvnc:alpine318

# set version label
ARG BUILD_DATE
ARG VERSION
ARG XFCE_VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="thelamer"


RUN \
  echo "**** install packages ****" && \
  apk update && \
  apk add --no-cache \
    faenza-icon-theme \
    faenza-icon-theme-xfce4-appfinder \
    faenza-icon-theme-xfce4-panel \
    mousepad \
    ristretto \
    thunar \
    util-linux-misc \
    xfce4 \
    xfce4-terminal && \
  wget -P /tmp https://dl-cdn.alpinelinux.org/alpine/v3.11/community/x86_64/chromium-81.0.4044.113-r0.apk && \
  apk add --allow-untrusted /tmp/chromium-81.0.4044.113-r0.apk && \
  echo "**** application tweaks ****" && \
  sed -i \
    's#^Exec=.*#Exec=/usr/local/bin/wrapped-chromium#g' \
    /usr/share/applications/chromium.desktop && \
  mv /usr/bin/exo-open /usr/bin/exo-open-real && \
  echo "**** cleanup ****" && \
  rm -f \
    /etc/xdg/autostart/xfce4-power-manager.desktop \
    /etc/xdg/autostart/xscreensaver.desktop \
    /usr/share/xfce4/panel/plugins/power-manager-plugin.desktop && \
  rm -rf \
    /config/.cache \
    /tmp/*

# add local files
COPY /root /

# ports and volumes
EXPOSE 3000

VOLUME /config
