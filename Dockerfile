FROM alpine AS build
WORKDIR /
RUN echo 'https://mirrors.tuna.tsinghua.edu.cn/alpine/latest-stable/main' > /etc/apk/repositories \
 && echo 'https://mirrors.tuna.tsinghua.edu.cn/alpine/latest-stable/community' >> /etc/apk/repositories \
 && apk add bash ca-certificates curl perl \
 && curl -4sSkLO https://raw.github.com/zfl9/gfwlist2privoxy/master/gfwlist2privoxy \
 && bash gfwlist2privoxy 127.0.0.1:1080

FROM v2fly/v2fly-core
RUN apk --no-cache add privoxy
COPY --from=build /gfwlist.action /etc/privoxy/
RUN echo 'actionsfile gfwlist.action' >> /etc/privoxy/config \
 && sed -i '/listen-address/d' /etc/privoxy/config \
 && echo 'listen-address 0.0.0.0:8118' >> /etc/privoxy/config

COPY entrypoint.sh /entrypoint.sh

EXPOSE 8118

ENTRYPOINT ["/entrypoint.sh"]