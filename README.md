# Stream to multiple RTMP destinations

With this docker imagen you can stream to multiple RTMP destinations as:

* Youtube
* Twitch
* and more (work in progress)

# How to use this image
## Exposing external ports

    $ docker run --name rtmp-multi -d -p 8080:80 -p 1935:1935 \
        redstar/rtmp-multi-destination:latest

## Exposing recordings directory

    $ docker run --name rtmp-multi -v /local_path:/var/www/html/recordings \
        -d -p 8080:80 -p 1935:1935 \
        redstar/rtmp-multi-destination:latest

## Streaming to Youtube

    $ docker run --name rtmp-multi -v /local_path:/var/www/html/recordings \
        -d -p 8080:80 -p 1935:1935 \
        -e "RTMP_YOUTUBE_URLS=key1 key2" \
        redstar/rtmp-multi-destination:latest

Then you can hit `http://localhost:8080/recordings` or `http://host-ip:8080/recordings` in your browser to watch recorded streams and configure your stream software to `rtmp://localhost/live` or `rtmp://host-ip/live`.

