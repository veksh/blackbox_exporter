FROM golang:alpine

WORKDIR /go/src/github.com/prometheus/blackbox_exporter

COPY . .

RUN apk add make git && \
    go get && \
    make build

RUN apk add -U libcap


RUN cp blackbox_exporter  /bin/blackbox_exporter
COPY blackbox.yml       /etc/blackbox_exporter/config.yml

ARG USERNAME=blackbox_exporter

RUN setcap cap_net_raw+ep /bin/blackbox_exporter

RUN adduser -D -u 1000 ${USERNAME}

WORKDIR /home/${USERNAME}

USER $USERNAME

EXPOSE      9115
ENTRYPOINT  [ "/bin/blackbox_exporter" ]
CMD         [ "--config.file=/etc/blackbox_exporter/config.yml" ]
