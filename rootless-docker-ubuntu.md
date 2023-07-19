# Run the Docker daemon as a non-root user (Rootless mode) - Ubuntu

The documentation will help to setup and manage rootless Docker for the specific non-root user who runs the commands.

## Installation

Run the following command

    $ dockerd-rootless-setuptool.sh install

    [INFO] Creating /home/testuser/.config/systemd/user/docker.service
    [INFO] Installed docker.service successfully.
    [INFO] To control docker.service, run: `systemctl --user (start|stop|restart) docker.service`
    [INFO] To run docker.service on system startup, run: `sudo loginctl enable-linger testuser`

    [INFO] Make sure the following environment variables are set (or add them to ~/.bashrc):
    export PATH=/usr/bin:$PATH
    export DOCKER_HOST=unix:///run/user/1000/docker.sock

Please that note of the two export commands that need be run initially and to be placed in `./bashrc`. **DO NOT** use the export commands from the example above
as they relate to `testuser` user who is not present within the DMC DTNs.

If the above `dockerd-rootless-setuptool.sh` is not found, use the installation script available at https://get.docker.com/rootless by running the following command
    
    $ curl -fsSL https://get.docker.com/rootless | sh

Reference: Run the Docker daemon as a non-root user (Rootless mode) [https://docs.docker.com/engine/security/rootless/]


## Start Rootless Docker

As systemd is used by default, starting Docker as rootless mode is straightforward.

The systemd unit file is installed as `~/.config/systemd/user/docker.service`.

Once rootless docker has been installed as documentated above, use `systemctl --user` to manage the lifecycle of the daemon:

    $ systemctl --user start docker

To launch the daemon on system startup, enable the systemd service and lingering:

     $ systemctl --user enable docker
     $ sudo loginctl enable-linger $(whoami)

Rootless Docker will now be running and ready for use.

## Uninstall

When finished, please help to clean up the rootless Docker setup:

To remove the systemd service of the Docker daemon, run `dockerd-rootless-setuptool.sh uninstall`

    $ dockerd-rootless-setuptool.sh uninstall

    + systemctl --user stop docker.service
    + systemctl --user disable docker.service
    Removed /home/testuser/.config/systemd/user/default.target.wants/docker.service.
    [INFO] Uninstalled docker.service
    [INFO] This uninstallation tool does NOT remove Docker binaries and data.
    [INFO] To remove data, run: `/usr/bin/rootlesskit rm -rf /home/testuser/.local/share/docker`
    
---   
    
Edited from [Run the Docker daemon as a non-root user](https://docs.docker.com/engine/security/rootless) found at docs.docker.com.
