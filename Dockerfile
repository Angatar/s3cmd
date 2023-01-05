FROM alpine:latest
LABEL org.opencontainers.image.authors="d3fk"

RUN apk add --no-cache python3 py3-six py3-pip py3-setuptools libmagic git ca-certificates

RUN pip install python-magic \
  && git clone https://github.com/s3tools/s3cmd.git /tmp/s3cmd \
  && cd /tmp/s3cmd \
  && python3 /tmp/s3cmd/setup.py install \
  && cd / \
  && rm -rf /tmp/s3cmd \
  && apk del py-pip git

WORKDIR /s3

ENTRYPOINT ["s3cmd"]
CMD ["--help"]
