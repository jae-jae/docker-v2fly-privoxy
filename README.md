# docker-v2fly-privoxy

Docker版v2ray客户端,v2ray 结合 privoxy 来使用 gfwlist 规则来实现代理过滤, 并实现 socks5 代理转 http 代理，适用于群晖。

> DockerHub: https://hub.docker.com/r/jaegerdocker/v2fly-privoxy

## 运行
```shell
docker run -dti -p 8118:8118 \
    -v /path/to/v2ray/config.json:/etc/v2ray/config.json \ 
    jaegerdocker/v2fly-privoxy
```
- `8118` 端口为 http 代理端口
- `/path/to/v2ray/config.json` 为宿主机上 v2ray 配置文件
- v2ray 配置文件中的 socks 端口必须是 `1080`

或者自定义 privoxy 配置文件
```shell
docker run -dti -p 8118:8118 \
    -v /path/to/v2ray/config.json:/etc/v2ray/config.json \
    -v /path/to/privoxy/config:/etc/privoxy/config \ 
    jaegerdocker/v2fly-privoxy
```

- `/path/to/privoxy/config` 为宿主机上的 privoxy 配置文件

