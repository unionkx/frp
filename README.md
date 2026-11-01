# frp for docker


```
docker pull ghcr.io/unionkx/frp:main
```

CLI usage:
```
docker run \
    -d \
    --name frp \
    -p 7000:7000 \
    -v $(pwd)/frpc.ini:/etc/frpc.ini \
    unionkx/frp \
    frpc -c /etc/frpc.ini
```

Compose example:
```
frp:
    image: unionkx/frp
    ports:
        - "7000:7000"
    volumes:
        - ./frpc.ini:/etc/frpc.ini
    command: frpc -c /etc/frpc.ini
  restart: always
```
