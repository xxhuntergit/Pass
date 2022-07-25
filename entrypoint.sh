#!/bin/sh

# Nginx default config file
cat << EOF > /etc/nginx/http.d/default.conf
server {
    listen $NIGNX_PORT default_server;
    listen [::]:$NIGNX_PORT default_server;
    charset utf-8;

    location /$YOUR_PATH {
    proxy_redirect off;
    proxy_pass http://127.0.0.1:44333;
    proxy_http_version 1.1;
    proxy_set_header Upgrade \$http_upgrade;
    proxy_set_header Connection "upgrade";
    proxy_set_header Host \$http_host;
    }

}
EOF

# Start Nginx
nginx && echo "Nginx started"

# Run app
/usr/local/bin/pass -config $APP_CONFIG_URL

