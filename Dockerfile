FROM ubuntu 

LABEL AUTHOR Andrew McCall <andrew@andrewmccall.com>

RUN apt-get update \
    && apt-get install -y wget \
    && rm -rf /var/lib/apt/lists/* 

ARG VERSION="v1.1.2"
RUN mkdir -p /opt/geth/bin && wget "https://github.com/binance-chain/bsc/releases/download/v1.1.2/geth_linux" -O /opt/geth/bin/geth 
RUN chmod +x /opt/geth/bin/geth
WORKDIR "/opt/geth"

RUN mkdir -p /opt/geth/config
COPY config/ ./config/

RUN mkdir -p /opt/geth/node

ENV GETH_DATA_DIRECTORY="/opt/geth/node"
ENV GETH_CONFIG_DIRECTORY="/opt/geth/config"

EXPOSE 30311/udp
EXPOSE 30311/tcp
EXPOSE 8545/tcp
EXPOSE 8546/tcp
EXPOSE 6060/tcp

COPY entrypoint.sh ./
ENTRYPOINT [ "./entrypoint.sh" ]
