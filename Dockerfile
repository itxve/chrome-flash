FROM lscr.io/linuxserver/webtop:ubuntu-xfce

RUN \
	echo "**** download software ****" && \
	apt-get update && \
	apt-get -y remove firefox && \
	apt-get install -qy --no-install-recommends wget bzip2 && \
  wget -P /tmp https://ftp.mozilla.org/pub/firefox/releases/53.0.3/linux-x86_64/zh-CN/firefox-53.0.3.tar.bz2 && \
	wget -P /tmp https://fpdownload.macromedia.com/pub/flashplayer/updaters/32/flash_player_sa_linux_debug.x86_64.tar.gz && \
	wget -P /tmp https://fpdownload.macromedia.com/pub/flashplayer/updaters/32/flash_player_sa_linux.x86_64.tar.gz && \
	wget -O /tmp/flashplayer32_0r0_371_linux_debug.x86_64.tar.gz https://archive.org/download/flashplayerarchive/pub/flashplayer/installers/archive/fp_32.0.0.371_archive.zip/32_0_r0_371_debug%2Fflashplayer32_0r0_371_linux_debug.x86_64.tar.gz && \
	echo "**** extract files ****" && \
	ls -l /tmp && mkdir /player && \
	tar -C /player -zxvf /tmp/flash_player_sa_linux.x86_64.tar.gz flashplayer && \
	tar -C /player -zxvf /tmp/flash_player_sa_linux_debug.x86_64.tar.gz flashplayerdebugger && \
	tar -C / -zxvf /tmp/flashplayer32_0r0_371_linux_debug.x86_64.tar.gz usr && \
	mkdir -p /usr/lib/mozilla/plugins && \
	tar -C /usr/lib/mozilla/plugins -zxvf /tmp/flashplayer32_0r0_371_linux_debug.x86_64.tar.gz libflashplayer.so &&\
	ln -s /player/flashplayer /usr/bin/flashplayer && \
	ln -s /player/flashplayerdebugger /usr/bin/flashplayerdebugger && \
  tar -xf /tmp/firefox-53.0.3.tar.bz2 && \
	ln -s /firefox/firefox /usr/bin/firefox && \
	echo "**** install deps ****" && \
	apt-get install -qy --no-install-recommends \
		x11-apps \
		dbus-x11 \
		libcurl4 \
		libgtk-3-0 \
		libgtk2.0-0 \
		libdbus-glib-1.2 \
		busybox \
		fonts-wqy-microhei &&\	
	echo "**** clean up ****" && \
 	rm -rf \
	/tmp/* \
	/var/lib/apt/lists/* \
	/var/tmp/*