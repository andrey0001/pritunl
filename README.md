## Pritunl as a Docker container

Just build it or pull it from andrey0001/pritunl. Run it something like this:

```
docker run --privileged --name pritunl --restart unless-stopped  --net=host -d -t andrey0001/pritunl
```

If you have a mongodb somewhere you'd like to use for this rather than starting the built-in one you can
do so through the MONGODB_URI env var like this:

```
docker run --privileged -e MONGODB_URI=mongodb://some-mongo-host:27017/pritunl --name pritunl --restart unless-stopped  --net=host -d -t andrey0001/pritunl
```

Then you can login to your pritunl web ui at https://docker-host-address/
Username: pritunl Password: pritunl

Then change 443 port to 9700 in Settings

To disable listen on 80 port, enter to the container:

```
docker exec -it pritunl bash
```

and run:
```
pritunl set app.redirect_server false
```


To enable LZO compression, create server and organization, attach organization to the server, then connect to the container:
```
docker exec -it pritunl bash
```
connect to mongo:
```
mongo pritunl
```
and run:
```
db.servers.update({}, {$set: {"lzo_compression" : true}}, { multi: true })
```
 

Then you're on your own, but take a look at http://pritunl.com or https://github.com/pritunl/pritunl

Статья на русском языке - Article in Russian - http://andrey.org/openvpn-pritunl-docker/

