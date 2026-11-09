#!/usr/bin/env bash

url="https://127.0.0.1/"
certificate="/etc/pki/nginx/secure-linux.crt"
timestamp=$(date -Is)

if status=$(curl --silent --show-error \
    --connect-timeout 5 --max-time 10 \
    --cacert "$certificate" \
    --output /dev/null --write-out '%{http_code}' \
    "$url"); then
    if [ "$status" = "200" ]; then
        echo "$timestamp HEALTHY: $url returned HTTP 200"
        exit 0
    fi

    echo "$timestamp UNHEALTHY: $url returned HTTP $status"
    exit 1
fi

echo "$timestamp UNHEALTHY: connection or certificate verification failed"
exit 1
