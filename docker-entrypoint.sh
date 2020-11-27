#!/bin/bash

# Ensure directory permissions
chown www-data.www-data /var/www/html/recordings/

# Check if Youtube URLS are present
if [ -n "$RTMP_YOUTUBE_URLS" ]; then
    # Load them one by one
    for URL in ${RTMP_YOUTUBE_URLS}; do
        # If it is NOT a rtmp scheme, only a key, then add default base URL to it
        if [ "${URL%%:*}" != "rtmp" ]; then
            URL="${RTMP_YOUTUBE_BASE}${URL}"
	fi
        # Output one "push" per Youtube URL
        echo "push ${URL};" >> /etc/nginx/rtmp.d/youtube.conf
    done
fi

# Check if Twitch URLS are present
if [ -n "$RTMP_TWITCH_URLS" ]; then
    # Load them one by one
    for URL in ${RTMP_TWITCH_URLS}; do
        # If it is NOT a rtmp scheme, only a key, then add default base URL to it
        if [ "${URL%%:*}" != "rtmp" ]; then
            URL="${RTMP_TWITCH_BASE}${URL}"
	fi
        # Output one "push" per Twitch URL
        echo "push ${URL};" >> /etc/nginx/rtmp.d/twitch.conf
    done
fi

# Check if Facebook URLS are present
if [ -n "$RTMP_FACEBOOK_URLS" ]; then
    # Load them one by one
    for URL in ${RTMP_FACEBOOK_URLS}; do
        # If it is NOT a rtmp scheme, only a key, then add default base URL to it
        if [ "${URL%%:*}" != "rtmp" ]; then
            URL="${RTMP_FACEBOOK_BASE}${URL}"
	fi
        # Output one "push" per Twitch URL
        echo "push ${URL};" >> /etc/nginx/rtmp.d/facebook.conf
    done
fi

exec "$@"

