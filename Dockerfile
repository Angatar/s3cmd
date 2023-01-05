FROM alpine:latest
LABEL org.opencontainers.image.authors="d3fk"

RUN apk add --no-cache python3 py3-six py3-pip py3-setuptools libmagic git ca-certificates

RUN git clone https://github.com/s3tools/s3cmd.git /tmp/s3cmd \
  && cd /tmp/s3cmd \
  && pip install python-dateutil python-magic \
  && python3 /tmp/s3cmd/setup.py install \
  && cd / \
  && apk del py3-pip git \
  && rm -rf /root/.cache/pip /tmp/s3cmd 

WORKDIR /s3

ENTRYPOINT ["s3cmd"]
CMD ["--help"]
