FROM alpine:latest

ENV CONFIG_JSON=none CERT_PEM=none KEY_PEM=none VER=4.1

RUN apk add --no-cache --virtual .build-deps ca-certificates curl
RUN mkdir -m 777 /v2raybin
RUN cd /v2raybin
RUN curl -L -H "Cache-Control: no-cache" -o v2ray.zip https://github.com/v2ray/v2ray-core/releases/download/v$VER/v2ray-linux-64.zip
RUN unzip v2ray.zip
RUN mv /v2raybin/v2ray-v$VER-linux-64/v2ray /v2raybin/
RUN mv /v2raybin/v2ray-v$VER-linux-64/v2ctl /v2raybin/
RUN mv /v2raybin/v2ray-v$VER-linux-64/geoip.dat /v2raybin/
RUN mv /v2raybin/v2ray-v$VER-linux-64/geosite.dat /v2raybin/
RUN chmod +x /v2raybin/v2ray
RUN rm -rf v2ray.zip
RUN rm -rf v2ray-v$VER-linux-64
RUN chgrp -R 0 /v2raybin
RUN chmod -R g+rwX /v2raybin
 
ADD entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

ENTRYPOINT  /entrypoint.sh

EXPOSE 8080
EXPOSE 8285
