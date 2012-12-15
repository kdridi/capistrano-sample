#!/usr/bin/env bash

cd $(dirname $0)/..

cat << EOF | sudo sh -c "cat > /etc/nginx/sites-available/$1.conf"
upstream unicorn {
  server unix:$(pwd)/tmp/unicorn.sock fail_timeout=0;
}

server {
  listen 80 default deferred;
  # server_name  localhost;
  root $(pwd)/public;

  location ^~ /assets/ {
    gzip_static on;
    expires max;
    add_header Cache-Control public;
  }

  try_files \$uri/index.html \$uri @unicorn;
  location @unicorn {
    proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
    proxy_set_header Host \$http_host;
    proxy_redirect off;
    proxy_pass http://unicorn;
  }

  error_page 404             /404.html;
  error_page 500 502 503 504 /500.html;
  client_max_body_size 4G;
  keepalive_timeout 10;
}
EOF

cd /etc/nginx/sites-enabled
ln -sf ../sites-available/$1.conf .
