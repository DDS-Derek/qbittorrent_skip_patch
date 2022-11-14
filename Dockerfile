#FROM ddsderek/qbittorrent_skip_patch:build_base AS build

##################################
#ENV qbitorrent_tag=4.4.5
#ENV libtorrent_tag=LPE_v0.4
##################################

#WORKDIR /build

#RUN qbitorrent_github_tag=release-${qbitorrent_tag} \
#    libtorrent_github_tag=${libtorrent_tag} \
#    bash qbittorrent-nox-static.sh qbittorrent


FROM lsiobase/alpine:3.12

ENV TZ=Asia/Shanghai \
	WEBUIPORT=8080 \
	PUID=1000 \
	PGID=1000 \
	UMASK_SET=022 \
    TL=https://githubraw.sleele.workers.dev/XIU2/TrackersListCollection/master/best.txt \
    UT=true

RUN apk add --no-cache python3 && \
    rm -rf /var/cache/apk/*

COPY --chmod=755 root /
COPY --from=ddsderek/qbittorrent_skip_patch:downloader-2022-11-14 --chmod=755 /qb/4_2_x_RC_1_2/x86_64-qt5-qbittorrent-nox   /usr/local/bin/qbittorrent-nox

VOLUME /config

EXPOSE 8080
