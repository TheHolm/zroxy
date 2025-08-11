FROM alpine:latest AS build

RUN apk update && \
    apk add --no-cache git cmake gcc make musl-dev

WORKDIR /root
RUN git clone https://github.com/0x7a657573/zroxy.git && \
    mkdir zroxy/build && \
    cd zroxy/build && \
    cmake .. && \
    make

FROM alpine:latest AS release

COPY --from=build /root/zroxy/build/zroxy /usr/local/bin/zroxy

ENTRYPOINT ["/usr/local/bin/zroxy"]
