[Git](https://code.nephatrine.net/nephatrine/docker-minecraft-mcu/src/branch/master) |
[Docker](https://hub.docker.com/r/nephatrine/minecraft-mcu/) |
[unRAID](https://code.nephatrine.net/nephatrine/unraid-containers)

[![Build Status](https://ci.nephatrine.net/api/badges/nephatrine/docker-minecraft-mcu/status.svg?ref=refs/heads/master)](https://ci.nephatrine.net/nephatrine/docker-minecraft-mcu)

# Minecraft Server

This docker image contains a Minecraft server to self-host your own Java
Edition server and optionally MCUpdater modpack.

**YOU WILL NEED TO USE A SEPARATE REVERSE PROXY SERVER TO SECURE THIS SERVICE.
FOR INSTANCE, AN [NGINX](https://nginx.com/) REVERSE PROXY CONTAINER.**

- [Alpine Linux](https://alpinelinux.org/)
- [Skarnet Software](https://skarnet.org/software/)
- [S6 Overlay](https://github.com/just-containers/s6-overlay)
- [Minecraft](https://minecraft.net/)
- [MCUpdater](https://mcupdater.com/)

**Please note, you will still need to agree to the EULA the first time you
start up the server by changing ``eula=false`` to ``eula=true`` in the
``/mnt/config/data/server/eula.txt`` file.**

This container does not currently include its own web server. To expose your
modpack to the public, you will need to host the modpack directory on a web
server.

You can spin up a quick temporary test container like this:

~~~
docker run --rm -p 25565:25565 -it nephatrine/minecraft:latest /bin/bash
~~~

## Configuration Variables

You can set these parameters using the syntax ``-e "VARNAME=VALUE"`` on your
``docker run`` command. Some of these may only be used during initial
configuration and further changes may need to be made in the generated
configuration files.

- ``FABRIC_VERSION``: Fabric Loader Version (*""*)
- ``FORGE_VERSION``: Minecraft Forge Version (*recommended*)
- ``MINECRAFT_VERSION``: Minecraft Version (**)
- ``JAVA_OPTS``: Java Commandline Arguments (*""*)
- ``MODPACK_NAME``: Modpack Name (*custom*)
- ``MODPACK_PUBLIC``: Modpack Download URL (*https://*``[SERVER_PUBLIC]``)
- ``PUID``: Mount Owner UID (*1000*)
- ``PGID``: Mount Owner GID (*100*)
- ``SERVER_NAME``: Server Name (*custom*)
- ``SERVER_PUBLIC``: Server IP/FQDN (*""*)
- ``TZ``: System Timezone (*America/New_York*)

If a ``MINECRAFT_VERSION`` is specified but neither ``FABRIC_VERSION`` nor
``FORGE_VERSION`` are specified, it will default to the recommended version of
Forge for that Minecraft Version. If there is no recommended version of Forge,
then it will default to the latest Fabric release.

## Persistent Mounts

You can provide a persistent mountpoint using the ``-v /host/path:/container/path``
syntax. These mountpoints are intended to house important configuration files,
logs, and application state (e.g. databases) so they are not lost on image
update.

- ``/mnt/config``: Persistent Data.

Do not share ``/mnt/config`` volumes between multiple containers as they may
interfere with the operation of one another.

You can perform some basic configuration of the container using the files and
directories listed below.

- ``/mnt/config/data/server/eula.txt``: Accept Minecraft EULA. [*]
- ``/mnt/config/data/server/server.properties``: Set Minecraft Properties. [*]
- ``/mnt/config/etc/crontabs/<user>``: User Crontabs. [*]
- ``/mnt/config/etc/logrotate.conf``: Logrotate Global Configuration.
- ``/mnt/config/etc/logrotate.d/``: Logrotate Additional Configuration.
- ``/mnt/config/www/minecraft/modpack/client/*``: Client-Side Optional Mods. [*]
- ``/mnt/config/www/minecraft/modpack/config/*``: Mod Configuration Files. [*]
- ``/mnt/config/www/minecraft/modpack/extract/*``: Modpack Zipfiles. [*]
- ``/mnt/config/www/minecraft/modpack/mods/*``: Minecraft Mods. [*]
- ``/mnt/config/www/minecraft/modpack/optional/*``: Optional Mods. [*]
- ``/mnt/config/www/minecraft/modpack/scripts/*``: Minecraft Tweaking Scripts. [*]
- ``/mnt/config/www/minecraft/modpack/server/*``: Server-Side Optional Mods. [*]
- ``/mnt/config/www/minecraft/modpack.xsl``: MCUpdater Modpack Theming. [*]

**[*] Changes to some configuration files may require service restart to take
immediate effect.**

## Network Services

This container runs network services that are intended to be exposed outside
the container. You can map these to host ports using the ``-p HOST:CONTAINER``
or ``-p HOST:CONTAINER/PROTOCOL`` syntax.

- ``25565/tcp``: Minecraft Server. This is the game server.
