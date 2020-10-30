FROM debian:buster-slim

LABEL maintainer="Oscar Garcia https://github.com/ojgarciab/"

RUN apt-get update && \
  apt-get -y install nginx-full libnginx-mod-rtmp

RUN mkdir -p /var/www/html/recordings/ /etc/nginx/rtmp.d/ && \
  sed -ri 's#^(\tlocation / \{)#\1\n\t\tautoindex on;#' /etc/nginx/sites-enabled/default && \
  echo -e "\n\nrtmp {\n\tserver {\n\t\tlisten 1935;\n\t\tapplication live {\n\t\t\tlive on;\n\t\t\trecord all;\n\t\t\trecord_path /var/www/html/recordings;\n\t\t\trecord_unique on;\n\t\t\tinclude /etc/nginx/rtmp.d/*.conf;\n\t\t}\n\t}\n}\n" >> /etc/nginx/sites-enabled/default

EXPOSE 80
EXPOSE 1935


