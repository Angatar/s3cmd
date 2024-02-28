FROM alpine:latest
LABEL org.opencontainers.image.authors="d3fk"
LABEL org.opencontainers.image.source="https://github.com/Angatar/s3cmd.git"
LABEL org.opencontainers.image.url="https://github.com/Angatar/s3cmd"

RUN apk upgrade --no-cache \
  &&  echo  https://dl-cdn.alpinelinux.org/alpine/edge/community >> /etc/apk/repositories \
  && apk add --no-cache ca-certificates s3cmd

WORKDIR /s3

ENTRYPOINT ["s3cmd"]
CMD ["--help"]
