# Stream to multiple RTMP destinations

With this docker imagen you can stream to multiple RTMP destinations as:

* Youtube
* Twitch
* and more (work in progress)

# How to use this image
## Exposing external ports

    $ docker run --name rtmp-multi \
        -d -p 8080:80 -p 1935:1935 \
        redstar/rtmp-multi-destination:latest

## Exposing recordings directory

    $ docker run --name rtmp-multi \
        -d -p 8080:80 -p 1935:1935 \
        -v /local_path:/var/www/html/recordings \
        redstar/rtmp-multi-destination:latest

## Streaming to Youtube

    $ docker run --name rtmp-multi \
        -d -p 8080:80 -p 1935:1935 \
        -v /local_path:/var/www/html/recordings \
        -e "RTMP_YOUTUBE_URLS=key1 key2" \
        redstar/rtmp-multi-destination:latest

## Streaming to Twitch

    $ docker run --name rtmp-multi \
        -d -p 8080:80 -p 1935:1935 \
        -v /local_path:/var/www/html/recordings \
        -e "RTMP_TWITCH_URLS=key1 key2" \
        -e "RTMP_TWITCH_BASE=$(curl -q 'https://ingest.twitch.tv/ingests' 2> /dev/null | egrep -om 1 "rtmp://[^.]+.twitch.tv/app/")" \
        redstar/rtmp-multi-destination:latest

## Streaming to Facebook

    $ docker run --name rtmp-multi \
        -d -p 8080:80 -p 1935:1935 \
        -v /local_path:/var/www/html/recordings \
        -e "RTMP_FACEBOOK_URLS=key1 key2" \
        redstar/rtmp-multi-destination:latest

## Addind own push servers

    $ docker run --name rtmp-multi \
        -d -p 8080:80 -p 1935:1935 \
        -v /local_path:/var/www/html/recordings \
        -v /local_file.conf:/etc/nginx/rtmp.d/remote_file.conf \
        redstar/rtmp-multi-destination:latest

Then you can hit `http://localhost:8080/recordings` or `http://host-ip:8080/recordings` in your browser to watch recorded streams and configure your stream software to `rtmp://localhost/live` or `rtmp://host-ip/live`.

