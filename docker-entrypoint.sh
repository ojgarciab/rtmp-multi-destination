#!/bin/bash

# Check if Youtube URLS are present
if [ -n "$RTMP_YOUTUBE_URLS" ]; then
    # Load them one by one
    for URL in ${RTMP_YOUTUBE_URLS}; do
        # If it is NOT a rtmp scheme, only a key, then add default base URL to it
        if [ "${URL%%:*}" != "rtmp" ]; then
            URL="rtmp://a.rtmp.youtube.com/live2/$URL"
	fi
        # Output one "push" per Youtube URL
        echo "push ${URL}" >> /etc/nginx/rtmp.d/youtube.conf
    done
fi

exec "$@"

