# Local Samba Server

![GitHub followers](https://img.shields.io/github/followers/4lbertojordan?style=social)

[![Build Samba Container](https://github.com/4lbertojordan/samba/actions/workflows/build_container.yml/badge.svg?branch=main)](https://github.com/4lbertojordan/samba/actions/workflows/build_container.yml)
![GitHub release (latest by date)](https://img.shields.io/github/v/release/4lbertojordan/samba?style=flat-square&logo=github&color=blue)
![GitHub last commit](https://img.shields.io/github/last-commit/4lbertojordan/samba?style=flat-square)
![GitHub stars](https://img.shields.io/github/stars/4lbertojordan/samba?style=flat-square)
![GitHub issues](https://img.shields.io/github/issues/4lbertojordan/samba?style=flat-square)
![GitHub License](https://img.shields.io/github/license/4lbertojordan/samba?style=flat-square)

![Docker Image Version (latest semver)](https://img.shields.io/docker/v/jord4ncodes/samba?sort=semver&style=flat-square&logo=docker)
![Docker Pulls](https://img.shields.io/docker/pulls/jord4ncodes/samba?style=flat-square&logo=docker)
![Docker Image Size](https://img.shields.io/docker/image-size/jord4ncodes/samba/latest?style=flat-square&logo=docker)
![Docker Image ARM](https://img.shields.io/badge/docker%20image-arm64-blue?style=flat-square&logo=docker)
![Docker Image x86-64](https://img.shields.io/badge/docker%20image-x86--64-blue?style=flat-square&logo=docker)

Basic Samba container ready to share files between Windows, macOS, and Linux.
This container is ideal for people who want to deploy a simple SAMBA server.
Designed for Raspberry Pi or homelab computers with Docker or similar installed.

This example includes some folders that I usually use in my regular Samba server. Customize the folders you want to share to your preference.

## Features

- Debian-based image.
- User/password authentication.
- Optimized configuration for Windows and macOS clients.
- Persistent volumes for logs and Samba database.
- Healthcheck included.
- IP restriction.
- Minimum protocol version 3.

## Requirements

- Docker installed.
- Available ports: `445/tcp`.
- ARM64 or x86-64 architecture.
- User permissions on the host to use shared folders.

## File Structure

- Samba configuration: [/smb.conf](smb.conf)
- Entrypoint: [/entrypoint.sh](entrypoint.sh)
- Environment variables example: [/environment.txt](environment.txt)
- Original image: [/smb.dockerfile](smb.dockerfile)
- Docker compose: [/docker-compose.yml](docker-compose.yml)

## Usage with Docker Run

1. Create a `.env.samba` file on your host:

```dotenv
SMB_USER=jordancodes
SMB_PASSWORD=your_secure_password
SMB_UID=995
SMB_GROUP=home
SMB_GID=1001
TZ=Europe/Madrid
```

2. Launch the container:

```bash
docker run -d \
	--name samba_server \
	--restart always \
	--env-file /YOUR_LOCAL_PATH/.env.samba \
	-p 445:445 \
	-v /docker-services/samba/smb.conf:/etc/samba/smb.conf:ro \
	-v /docker-services/samba/samba-data/lib:/var/lib/samba \
	-v /docker-services/samba/samba-data/log:/var/log/samba \
	-v /YOUR_LOCAL_PATH/data_net/general:/general \
	-v /YOUR_LOCAL_PATH/data_net/music:/music \
	-v /YOUR_LOCAL_PATH/data_net/pcgames:/pcgames \
	-v /YOUR_LOCAL_PATH/data_net/tvshows:/tvshows \
	-v /YOUR_LOCAL_PATH/data_net/movies:/movies \
	-v /YOUR_LOCAL_PATH/data_net/console:/console \
	-v /YOUR_LOCAL_PATH/data_net/pcsoftware:/pcsoftware \
	-v /YOUR_LOCAL_PATH/data_net/books:/books \
	-v /YOUR_LOCAL_PATH/data_net/savegame:/savegame \
	-v /YOUR_LOCAL_PATH/qbittorrent/downloads:/downloads \
	-v /YOUR_LOCAL_PATH/data_net/photos:/photos \
	samba:latest
```

## Usage with Docker Compose

Example of `docker-compose.yml`. Please remember to create the `.env.samba` file on your host:

```yaml
services:
  samba:
    build:
      context: .
      dockerfile: smb.dockerfile
    container_name: samba_server
    restart: always
    env_file:
      - /YOUR_LOCAL_PATH/.env.samba
    volumes:
      - /docker-services/samba/smb.conf:/etc/samba/smb.conf:ro
      - /docker-services/samba/samba-data/lib:/var/lib/samba
      - /docker-services/samba/samba-data/log:/var/log/samba
      - /YOUR_LOCAL_PATH/data_net/general:/general
      - /YOUR_LOCAL_PATH/data_net/music:/music
      - /YOUR_LOCAL_PATH/data_net/pcgames:/pcgames
      - /YOUR_LOCAL_PATH/data_net/tvshows:/tvshows
      - /YOUR_LOCAL_PATH/data_net/movies:/movies
      - /YOUR_LOCAL_PATH/data_net/console:/console
      - /YOUR_LOCAL_PATH/data_net/pcsoftware:/pcsoftware
      - /YOUR_LOCAL_PATH/data_net/books:/books
      - /YOUR_LOCAL_PATH/data_net/savegame:/savegame
      - /YOUR_LOCAL_PATH/qbittorrent/downloads:/downloads
      - /YOUR_LOCAL_PATH/data_net/photos:/photos
    ports:
      - "445:445"
    deploy:
      resources:
        limits:
          memory: 512M
```

## Environment Variables

These variables can be defined in the `.env` file or directly in the `docker-compose.yml`.

| Variable       | Description                                                       | Example                |
| -------------- | ----------------------------------------------------------------- | ---------------------- |
| `SMB_USER`     | System and Samba user.                                            | `jordancodes`          |
| `SMB_PASSWORD` | Samba password. If empty, the password is not created or updated. | `your_secure_password` |
| `SMB_UID`      | UID of the user in the container.                                 | `995`                  |
| `SMB_GROUP`    | Primary group of the user.                                        | `home`                 |
| `SMB_GID`      | GID of the group.                                                 | `1001`                 |
| `TZ`           | Timezone of the container.                                        | `Europe/Madrid`        |

## Shared Folders Configuration

Shared resources are defined in [smb.conf](smb.conf). Each section has its path inside the container:

- `[general]` → `/general`
- `[music]` → `/music`
- `[pcgames]` → `/pcgames`
- `[tvshows]` → `/tvshows`
- `[movies]` → `/movies`
- `[console]` → `/console`
- `[pcsoftware]` → `/pcsoftware`
- `[downloads]` → `/downloads`
- `[books]` → `/books`
- `[savegame]` → `/savegame`

If you want to change the server name or more global parameters, edit the `[global]` section in [smb.conf](smb.conf).

If you want to add more shared folders, create the folder on the host, add the volume in Docker, and add the corresponding section in `smb.conf`.

## Connecting from Clients

### Windows

In File Explorer, open:

```
\\SERVER_IP\general
```

### macOS

In Finder → Go → Connect to Server or `CMD+k`

```
smb://SERVER_IP/general
```

### Linux

Use your file manager or mount with:

```
sudo mount -t cifs //SERVER_IP/general /mnt/samba -o username=YOUR_USER,password=YOUR_PASSWORD
```

## Security

- This container exposes only port 445/tcp.
- It is recommended to adjust `hosts allow` in `smb.conf` to limit allowed networks.
- Use strong passwords.

## Contributing

Contributions are welcome! Please see [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

## Security Reporting

Please report security vulnerabilities responsibly by following the instructions in [SECURITY.md](SECURITY.md).

## License

See [LICENSE](LICENSE).
