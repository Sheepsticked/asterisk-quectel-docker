# Asterisk + chan_quectel

[![Build and push](https://github.com/dec0dos/asterisk-quectel-docker/actions/workflows/build_and_push.yml/badge.svg)](https://github.com/dec0dos/asterisk-docker/actions/workflows/build_and_push.yml)

This repository contains docker configuration and provides images for [Asterisk](https://www.asterisk.org/) with [chan_quectel](https://github.com/IchthysMaranatha/asterisk-chan-quectel).

Docker repository: [sheepsticked/asterisk-quectel-rpi](https://hub.docker.com/r/sheepsticked/asterisk-quectel-rpi)

GitHub repository: [Sheepsticked/asterisk-quectel-docker](https://github.com/Sheepsticked/asterisk-quectel-docker)

# Basic usage

## Using images from hub.docker.com

Dockerhub contains docker images with compiled binaries for the following platforms: amd64, arm64, armv7.

To start container run the following command:

```sh
docker run -dit --name asterisk --volume /etc/asterisk:/etc/asterisk --network host --device /dev/ttyUSB0:/dev/ttyUSB0 --device /dev/ttyUSB1:/dev/ttyUSB1 --device /dev/ttyUSB2:/dev/ttyUSB2 --device /dev/ttyUSB3:/dev/ttyUSB3 --device /dev/ttyUSB4:/dev/ttyUSB4 --restart unless-stopped sheepsticked/asterisk-quectel-rpi
```

where:

- `/etc/asterisk` is a directory with asterisk configuration.
- `--device /dev/ttyUSBX:/dev/ttyUSBX` is a path to the quectel USB devices

## Build yourself

To build the image locally run:

```sh
docker build -t asterisk-quectel https://raw.githubusercontent.com/Sheepsticked/asterisk-quectel-docker/master/Dockerfile
```

## Using docker compose

```yaml
services:
  asterisk:
    image: sheepsticked/asterisk-quectel-rpi
    container_name: asterisk-quectel
    network_mode: host
    privileged: true
    restart: unless-stopped
    volumes:
      - ./asterisk:/etc/asterisk
      - /dev:/dev
    logging:
      options:
        max-size: "100m"
        max-file: "5"
```
