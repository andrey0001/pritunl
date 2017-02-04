## Pritunl as a Docker container

Just build it or pull it from andrey0001/pritunl. Run it something like this:

```
docker run --privileged --name pritunl --hostname pritunl --restart unless-stopped  --net=host -d -t andrey0001/pritunl
```

If you have a mongodb somewhere you'd like to use for this rather than starting the built-in one you can
do so through the MONGODB_URI env var like this:

```
docker run --privileged -e MONGODB_URI=mongodb://some-mongo-host:27017/pritunl --name pritunl --hostname pritunl --restart unless-stopped  --net=host -d -t andrey0001/pritunl
```

Then you can login to your pritunl web ui at https://docker-host-address/
Username: pritunl Password: pritunl
Then change 443 port to 9700 in Settings

To disable listen on 80 port, exter to the container:

```
docker exec -it pritunl bash
```

and run:
```
pritunl set app.redirect_server false
```
Then you're on your own, but take a look at http://pritunl.com or https://github.com/pritunl/pritunl
