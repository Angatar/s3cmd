FROM alpine:latest
LABEL org.opencontainers.image.authors="d3fk"
LABEL org.opencontainers.image.source="https://github.com/Angatar/s3cmd.git"
LABEL org.opencontainers.image.url="https://github.com/Angatar/s3cmd"

RUN apk upgrade --no-cache \
  && apk add --no-cache libmagic git ca-certificates python3 py3-six py3-setuptools py3-dateutil py3-magic \
  && git clone https://github.com/s3tools/s3cmd.git /tmp/s3cmd \
  && cd /tmp/s3cmd \
  && python3 /tmp/s3cmd/setup.py install \
  && cd / \
  && apk del py3-setuptools git \
  && rm -rf /tmp/s3cmd 

WORKDIR /s3

ENTRYPOINT ["s3cmd"]
CMD ["--help"]
