FROM lsiobase/guacgui:arm64v8-latest

# set version label
ARG BUILD_DATE
ARG VERSION
ARG CALIBRE_RELEASE
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="aptalca"

ENV APPNAME="Calibre" UMASK_SET="022"

RUN \
 echo "**** install runtime packages ****" && \
 apt-get update && \
 apt-get install -y --no-install-recommends \
	dbus \
	fcitx-rime \
	fonts-wqy-microhei \
	jq \
	libqpdf21 \
	libxkbcommon-x11-0 \
	libxcb-icccm4 \
	libxcb-image0 \
	libxcb-keysyms1 \
	libxcb-randr0 \
	libxcb-render-util0 \
	libxcb-xinerama0 \
	python3 \
	python3-xdg \
	ttf-wqy-zenhei \
	wget \
	xz-utils && \
 echo "**** install calibre ****" && \
 mkdir -p \
	/opt/calibre && \
 CALIBRE_VERSION="" && \
 CALIBRE_URL="http://mirror.archlinuxarm.org/aarch64/community/calibre-5.3.0-2-aarch64.pkg.tar.xz" && \
 curl -o \
	/tmp/calibre-tarball.txz -L \
	"$CALIBRE_URL" && \
 tar Jxvf /tmp/calibre-tarball.txz -C \
	/ && \
 dbus-uuidgen > /etc/machine-id && \
 echo "**** cleanup ****" && \
 apt-get clean && \
 rm -rf \
	/tmp/* \
	/var/lib/apt/lists/* \
	/var/tmp/*

# add local files
COPY root/ /
