# dstargateway-docker
This is a way to run [DStarGateway](https://github.com/F4FXL/DStarGateway/) by F4FXL in Docker. It will build the latest develop code into a Docker Image and then the idea is to run a full stack all contained in one Docker Compose file.

The original idea came from a troubleshooting perspective as our D-STAR gateway is running AlmaLinux 9, but a lot of the non-native D-STAR software such as DStarGateway, ircDDBGateway, etc are developed with Debian in mind. I figured this was a way to test it in a cleaner and more "native" environment using Debian as a base. This also helps to contain all configuration, applications, and logs into one folder structure for simplification.

# To-dos
- Add [dsgwdashboard](https://github.com/johnhays/dsgwdashboard) to the stack. Currently I am running this bare-metal.
- Add [Ofelia](https://hub.docker.com/r/mcuadros/ofelia) to the stack. Currently I am running bare-metal crontabs, which is a bit overwhelming adding the extra commands for Docker. 
- Set environmental variables as needed (folders, UID/GID, etc). Perhaps change the build version of DStarGateway.
