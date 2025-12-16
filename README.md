# Asterisk + chan_quectel

This repository contains docker configuration and provides images for [Asterisk](https://www.asterisk.org/) with [chan_quectel](https://github.com/IchthysMaranatha/asterisk-chan-quectel).

Docker repository: [sheepsticked/asterisk-quectel-rpi](https://hub.docker.com/r/sheepsticked/asterisk-quectel-rpi)

GitHub repository: [Sheepsticked/asterisk-quectel-docker](https://github.com/Sheepsticked/asterisk-quectel-docker)

# Basic usage

## Using images from hub.docker.com

Dockerhub contains docker images with compiled binaries for the following platforms: arm64.

To start container run the following command:

```sh
docker run -dit --name asterisk --volume /etc/asterisk:/etc/asterisk --network host --device /dev/ttyUSB0:/dev/ttyUSB0 --device /dev/ttyUSB1:/dev/ttyUSB1 --device /dev/ttyUSB2:/dev/ttyUSB2 --device /dev/ttyUSB3:/dev/ttyUSB3 --device /dev/ttyUSB4:/dev/ttyUSB4 --restart unless-stopped sheepsticked/asterisk-quectel-rpi
```

where:

- `/etc/asterisk` is a directory with asterisk configuration.
- `--device /dev/ttyUSBX:/dev/ttyUSBX` is a path to the quectel USB devices

### Asterisk user

If your dongle uses a sound device (for example, in a Quectel EC25 module using UAC), you need to add the asterisk user on the host with the same UID as in docker and create a udev rule (or use another method) to fix the permissions for audio devices. In this docker image UID for asterisk user is 1456.

To create user:

```bash
sudo useradd -u 1456 -s /usr/sbin/nologin asterisk
```

Add asterisk user to audio group. Create `/etc/udev/rules.d/99-asterisk-sound.rules` with contents like:

Create `/etc/udev/rules.d/99-asterisk-sound.rules` with contents like:

```udev
SUBSYSTEM=="sound", ACTION=="add", OWNER="asterisk", GROUP="audio", MODE="0660"
```

Then

```bash
sudo udevadm control --reload
sudo udevadm trigger --subsystem-match=sound
```

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
```
