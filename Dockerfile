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

CMD (nohup ./bin/geth --config ./config/config.toml --datadir ./node/ --cache 18000 --rpc.allow-unprotected-txs --txlookuplimit 0 --ws --ipcdisable --metrics --metrics.addr=localhost &) && sleep 2 && tail -f ./node/bsc.log

EXPOSE 30311/udp
EXPOSE 30311/tcp
EXPOSE 8545/tcp
EXPOSE 8546/tcp