FROM debian:buster-slim

LABEL maintainer="Oscar Garcia https://github.com/ojgarciab/"

RUN apt-get update && \
    apt-get -y install nginx-full libnginx-mod-rtmp && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/www/html/recordings/ /etc/nginx/rtmp.d/ && \
    chown www-data.www-data /var/www/html/recordings/ && \
    sed -ri 's#^(\tlocation / \{)#\1\n\t\tautoindex on;#' /etc/nginx/sites-enabled/default && \
    echo "\n\ninclude /etc/nginx/rtmp.conf;\n" >> /etc/nginx/nginx.conf && \
    ln -sf /dev/stdout /var/log/nginx/access.log && \
    ln -sf /dev/stderr /var/log/nginx/error.log

COPY rtmp.conf /etc/nginx/rtmp.conf
COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]

# Default ingest servers (Twitch: US Central, Dallas, TX)
ENV RTMP_YOUTUBE_BASE="rtmp://a.rtmp.youtube.com/live2/" \
    RTMP_TWITCH_BASE="rtmp://live-dfw.twitch.tv/app/"

VOLUME ["/var/www/html/recordings/"]
EXPOSE 80 1935

STOPSIGNAL SIGTERM

CMD ["nginx", "-g", "daemon off;"]

