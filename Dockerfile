FROM debian:buster-slim

LABEL maintainer="Oscar Garcia https://github.com/ojgarciab/"

RUN apt-get update && \
    apt-get -y install nginx-full libnginx-mod-rtmp && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir -p /var/www/html/recordings/ /etc/nginx/rtmp.d/ && \
    sed -ri 's#^(\tlocation / \{)#\1\n\t\tautoindex on;#' /etc/nginx/sites-enabled/default && \
    echo "\n\ninclude /etc/nginx/rtmp.conf;\n" >> /etc/nginx/nginx.conf

COPY rtmp.conf /etc/nginx/rtmp.conf
COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]

VOLUME ["/var/www/html/recordings/"]
EXPOSE 80 1935

STOPSIGNAL SIGTERM

CMD ["nginx", "-g", "daemon off;"]

