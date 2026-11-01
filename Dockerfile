FROM golang:alpine as builder
ENV CGO_ENABLED=0
RUN apk add --no-cache curl build-base git libcap && \
    git clone https://github.com/fatedier/frp.git /root/frp && \
    cd /root/frp && \
    go build -v -ldflags "-s -w" -o /frps ./cmd/frps && \
    go build -v -ldflags "-s -w" -o /frpc ./cmd/frpc && \
    ls /frp* | xargs -n1 setcap 'cap_net_bind_service+ep' && \
    cp ./conf/frp* /etc/

FROM alpine
COPY --from=builder /frp* /usr/bin/
COPY --from=builder /etc/frp* /etc/
CMD ["/usr/bin/frps", "-c", "/etc/frps.ini"]
