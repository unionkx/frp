FROM debian:testing-slim
ENV FRP_VERSION=0.61.0
RUN mkdir /workspace
WORKDIR /workspace
RUN set -eux \
    && apt-get -qqy update  \
    && apt-get -qqy install --no-install-recommends \ 
    make \
    && wget -c https://github.com/fatedier/frp/releases/download/v${FRP_VERSION}/frp_${FRP_VERSION}_linux_amd64.tar.gz \
    && tar zxvf frp_${FRP_VERSION}_linux_amd64.tar.gz \
    && cd frp_${FRP_VERSION}_linux_amd64/ \
    && make \
    && cp -rfv bin conf /workspace/ \
    && apt-get -qqy --purge autoremove \
    && apt-get -qqy autoclean \

COPY --from=builder /workspace/bin/frpc /usr/bin/
COPY --from=builder /workspace/conf/frpc.toml /etc/frp/
ENTRYPOINT ["/usr/bin/frpc"]
CMD ["-c", "/etc/frp/frpc.toml"]
