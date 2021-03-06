## Pritunl as a Docker container


Just build it or pull it from andrey0001/pritunl . Run it something like this:


```
docker run --privileged -p 25114:443 -p 1194:1194/udp -p 1195:1195/udp --name pritunl --restart unless-stopped -d -t andrey0001/pritunl
```

If you have a mongodb somewhere you'd like to use for this rather than starting the built-in one you can
do so through the MONGODB_URI env var like this:

```
docker run --privileged -p 25114:443 -p 1194:1194/udp -p 1195:1195/udp -e MONGODB_URI=mongodb://some-mongo-host:27017/pritunl --name pritunl --restart unless-stopped -d -t andrey0001/pritunl
```

You can use variables:

REVERSE_PROXY

NO_REDIRECT_SERVER

NO_SSL

SERVER_PORT 

to  use with web-server, like nginx.

```
docker run --privileged -p 25114:443 -p 1194:1194/udp -p 1195:1195/udp \
-e REVERSE_PROXY=1 \
-e NO_REDIRECT_SERVER=1 \
-e NO_SSL=1 \
-e SERVER_PORT=9700
-e MONGODB_URI=mongodb://some-mongo-host:27017/pritunl \
--name pritunl --restart unless-stopped -d -t andrey0001/pritunl
```
Then, you can use nginx as frontend:

```
server {
    listen       443 ssl;
    server_name  pritunl.yourdomain;
    ssl_certificate /etc/letsencrypt/live/pritunl.yourdomain/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/pritunl.yourdomain/privkey.pem;
    ssl_session_cache shared:SSL:1m;
    ssl_session_timeout  5m;
    ssl_ciphers  HIGH:!aNULL:!MD5;
    ssl_prefer_server_ciphers   on;

  location / {
    proxy_pass      http://localhost:25114;
                     proxy_http_version 1.1;
                     proxy_set_header Upgrade $http_upgrade;
                     proxy_set_header Connection "upgrade";
                     proxy_set_header Host $http_host;
                     proxy_set_header X-Real-IP $remote_addr;
                     proxy_set_header X-Forward-For $proxy_add_x_forwarded_for;
                     proxy_set_header X-Forward-Proto http;
                     proxy_set_header X-Nginx-Proxy true;
                     proxy_redirect off;
  }
}
```

variables set before start pritunl:
```
REVERSE_PROXY - /usr/bin/pritunl set app.reverse_proxy true
NO_REDIRECT_SERVER - /usr/bin/pritunl set app.redirect_server false
NO_SSL - /usr/bin/pritunl set app.server_ssl false
SERVER_PORT - /usr/bin/pritunl set app.server_port $SERVER_PORT
```

Then you're on your own, but take a look at http://pritunl.com or https://github.com/pritunl/pritunl

Статья на русском языке - Article in Russian - http://andrey.org/openvpn-pritunl-docker/

