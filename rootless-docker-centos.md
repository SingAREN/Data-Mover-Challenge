# Run the Docker daemon as a non-root user (Rootless mode) - CentOS

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


## Start Rootless Docker

After performing the installation setup for Rootless Docker as instructed above, please open a new terminal window and run the following:

    $ dockerd-rootless.sh
    ...
    INFO[2021-07-05T10:15:37.204001065+08:00] Loading containers: done.
    INFO[2021-07-05T10:15:37.253417138+08:00] Docker daemoncommit=b0f5bc3 graphdriver(s)=vfs version=20.10.7
    INFO[2021-07-05T10:15:37.253514232+08:00] Daemon has completed initialization
    INFO[2021-07-05T10:15:37.265023563+08:00] API listen on /run/user/1001/docker.sock

Please take note that `$ dockerd-rootless.sh` is a foreground process thus the terminal where it is active should not be closed.
Closing the foreground processs will terminate all running containers. Run `$ dockerd-rootless.sh` to bring up the rootless Docker service again.

## Uninstall

When finished, please run cleanup rootless Docker:

    $ dockerd-rootless-setuptool.sh uninstall

    dockerd-rootless-setuptool.sh uninstall
    [INFO] systemd not detected, dockerd-rootless.sh needs to be stopped manually:
    [INFO] Deleted CLI context "rootless"
    [INFO] This uninstallation tool does NOT remove Docker binaries and data.
    [INFO] To remove data, run: `/usr/bin/rootlesskit rm -rf /home/testuser/.local/share/docker`

---   
    
Edited from [Run the Docker daemon as a non-root user](https://docs.docker.com/engine/security/rootless) found at docs.docker.com.
