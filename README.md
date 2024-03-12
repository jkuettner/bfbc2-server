# Docker-Images for Battlefield: Bad Company 2 LAN-Server

Many thanks to the [battlefieldbadcompany2mase project](https://sourceforge.net/projects/battlefieldbadcompany2mase/) by [flyer8472](https://sourceforge.net/u/flyer8472/profile/) for the great project, which enabled me to build these Docker-Images in the first place.

This projects contains two docker-images:
- The [master-server](#Master-Server) which is needed by the client to handle the user-account and manages the server-list
- The [game-server](#Game-Server) which the clients can connect to for gaming

With this both images you are able to run your own Battlefield Bad Company 2 LAN-Server.

# Quick-Start

The easiest way to start your own BFBC2 LAN-Server is to use [docker-compose](https://docs.docker.com/compose/install/) and run it with

```sh
docker-compose up -d
```

this command will start up the master-server and two game-servers (ruah and sqdm) with default configurations.

alternatively you can run the docker-images manually:

```sh
# master-server
docker run -t \
    -d --net=host \
    ghcr.io/jkuettner/bfbc2-master-server:master

# game-server
docker run \
    -d --net=host \
    ghcr.io/jkuettner/bfbc2-server:master
```

## Connecting to your LAN-Server

To be able to connect to your bfbc2-server you have to add the two files `bfbc2.ini` and `dinput8.dll` to your installed game-root-folder. This files are included in the `Bc2emu_V09.rar` ([download](https://sourceforge.net/projects/battlefieldbadcompany2mase/files/Bc2emu_V09.rar/download)) inside of the `"Crack - Copy to client root"`-directory.
Edit the line `host=127.0.0.1` in the `bfbc2.ini` and fill in the ip of your server.

In the game simply create a new account with dummy-data (the account data are saved in plain-text in the database-directory mounted to the master-server...)

Inside of the `Bc2emu_V09.rar` file is also included a `readme.txt` for detailed instructions.

# Master-Server

If you start the server without a database-volume the registered accounts are non-persistent and have to be recreated every time the container is recreated.

To enable persistence you have to create a local database folder and mount it to the docker-container (this is enabled by default in the [docker-compose.yaml](./docker-compose.yaml)):

```sh
mkdir ./database
docker run -t \
    -d --net=host \
    -v "./database:/home/bfbc2/database" \
    ghcr.io/jkuettner/bfbc2-master-server:master
```

You can overwrite the [config.ini](./master-server/config.ini) with your own by adding a custom `config.ini` as volume:

```sh
docker run \
    --rm -ti --host=net \
    -v ./database:/home/bfbc2/database \
    -v ./config.ini:/home/bfbc2/config.ini \
    ghcr.io/jkuettner/bfbc2-server:master
```

or edit the [docker-compose.yaml](./docker-compose.yaml) and uncomment the `- "./custom-config.ini:/home/bfbc2/config.ini"` line.

# Game-Server

## Environment

| Variable | Description | Default |
| ------------- |:-------------| -----:|
| `MASTER_SERVER`| the host to the master-server | `127.0.0.1` |
| `SERVER_TYPE`| the game mode of the server. One of `rush`, `conq`, `sqdm`, `sqrush`, `vietconq`, `vietrush`, `vietsqrush` or `vietsqdm` | `rush` |
| `SERVER_NAME`| the name of the server listed in the serverlist | `BFBC2 Server` |
| `SERVER_PORT`| the port of the server | `19567` |
| `SERVER_ADMIN_PORT`| the port for the remote admin-tool | `48888` |
| `SERVER_ADMIN_PASSWORD`| the admin password | `langaming` |
| `SERVER_MAX_PLAYERS`| the maximum amount of connectable players | `16` |
| `SERVER_HARDCORE`| set the hardcore mode | `false` |
| `SERVER_FF`| set friendly fire | `false` |
| `SERVER_TEAMBALANCE`| set teambalance | `true` |
| `SERVER_KILLCAM`| show killcam | `true` |
| `SERVER_MINIMAP`| show minimap | `true` |
| `SERVER_CROSSHAIR`| show crosshair | `true` |
| `SERVER_SPOTTING`| show spotting | `true` |
| `SERVER_MINIMAP_SPOTTING`| show minimap spotting | `true` |

## Maplists

The default [maplists](./game-server/maplists) can be overwritten by mounting your own maplist to `/home/bfbc2/server/maplists/<gamemode>.txt`

```sh
docker run \
    --rm -ti \
    -v "./custom_rushmaplist.txt:/home/bfbc2/server/maplists/rush.txt" \
    ghcr.io/jkuettner/bfbc2-server:master
```

## Multiple Game-Server

make sure that you have unique `SERVER_PORT` and `SERVER_ADMIN_PORT` env variables set per server instance.

# Build

Naturally you do not have to use the pre-build images from docker-hub. Simply build your own images:

```sh
docker build -t bfbc2-master-server ./master-server
docker build -t bfbc2-server ./game-server
```

# Known issues / Todos

## host-networking

Currently the docker-containers are startet in host-networking mode. Until now I was not able to run the containers with simple port-mappings. Neither the registration on the master server can be completed, nor can the game servers be found.

I am grateful for further tips

## Administration

Unfortunately, there are not many rcon-clients available (for bfbc2) anymore. However, on Windows I could manage the servers with [BC2 Guardian](https://g4g.pl/bc2guardian) without any problems.

I would prefer a web-based and self-hosted solution though, as I could bake this into the image if necessary. However, I have not been able to find anything like this, but would be very grateful for any hints!
