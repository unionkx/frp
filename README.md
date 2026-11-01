# frp for docker


```
docker pull ghcr.io/unionkx/frp:main
```

```
docker run \
    -d \
    --name frp \
    -p 7000:7000 \
    -v $(pwd)/frps.ini:/etc/frps.ini \
    zydou/frp \
    frpc -c /etc/frpc.ini
```
