FROM alpine:latest
ENV APP_CONFIG_URL=none YOUR_PATH=download LOGLEVEL=none NIGNX_PORT=80
ENV YOUR_APP_URL=https://github.com/xxhuntergit/Pass/releases/latest/download/pass.zip

RUN apk add --no-cache --virtual .build-deps ca-certificates nginx curl \
    && mkdir -p /run/nginx \
    && mkdir /tmp/install_temp \
    && curl -L -H "Cache-Control: no-cache" -o /tmp/install_temp/pass.zip $YOUR_APP_URL \
    && unzip /tmp/install_temp/pass.zip pass -d /tmp/install_temp/ \
    && install -m 755 /tmp/install_temp/pass /usr/local/bin/pass \
    && rm -rf /tmp/install_temp \

ADD default.conf /etc/nginx/http.d/default.conf
ADD index.html /var/lib/nginx/html/index.html

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE $NIGNX_PORT
ENTRYPOINT ["/entrypoint.sh"]
