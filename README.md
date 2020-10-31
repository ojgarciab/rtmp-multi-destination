# Stream to multiple RTMP destinations

With this docker imagen you can stream to multiple RTMP destinations as:

* Youtube
* Twitch
* and more (work in progress)

## Basic usage

# How to use this image
## Hosting some simple static content

    $ docker run --name rtmp-multi -v /local_path:/usr/share/nginx/html/recordings:ro -d redstar/rtmp-multi-destination:latest

## Exposing external port

    $ docker run --name rtmp-multi -d -p 8080:80 -p 1935:1935 redstar/rtmp-multi-destination:latest

Then you can hit `http://localhost:8080` or `http://host-ip:8080` in your browser and stream to `rtmp://localhost/live` or `rtmp://host-ip/live`.

