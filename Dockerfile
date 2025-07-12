FROM debian:bookworm-slim

RUN apt-get update && apt-get upgrade -y

RUN apt-get install -y curl

RUN mkdir /root/verus

RUN curl -sL https://github.com/VerusCoin/VerusCoin/releases/download/v1.2.9-5/Verus-CLI-Linux-v1.2.9-5-x86_64.tgz | tar xvzO --exclude='*.txt' | tar -xvzf - -C /root/verus

# Declare persistent volumes for blockchain and parameters
VOLUME ["/root/.zcash-params", "/root/.komodo"]

WORKDIR /root/verus/verus-cli

ENV VERUSD_RPC_USER=testuser
ENV VERUSD_RPC_PASSWORD=testpassword
ENV VERUSD_RPC_PORT=8080

COPY entrypoint.sh /root/verus/verus-cli/entrypoint.sh
RUN chmod +x /root/verus/verus-cli/entrypoint.sh

ENTRYPOINT ["bash", "/root/verus/verus-cli/entrypoint.sh"]