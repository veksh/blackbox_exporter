FROM golang:alpine

WORKDIR /go/src/github.com/prometheus/blackbox_exporter

COPY . .

RUN apk add make git && \
    go get && \
    make build

FROM        quay.io/prometheus/busybox:latest
MAINTAINER  The Prometheus Authors <prometheus-developers@googlegroups.com>

COPY --from=0 /go/src/github.com/prometheus/blackbox_exporter/blackbox_exporter  /bin/blackbox_exporter
COPY blackbox.yml       /etc/blackbox_exporter/config.yml

EXPOSE      9115
ENTRYPOINT  [ "/bin/blackbox_exporter" ]
CMD         [ "--config.file=/etc/blackbox_exporter/config.yml" ]
