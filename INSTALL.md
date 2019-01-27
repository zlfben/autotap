# Pre-requisite
 - docker
 - docker-compose

Please follow the instructions on https://docs.docker.com/compose/install/ to install both docker and docker-compose.

# Set up AutoTap
## Option \#1: Build AutoTap by yourself
### Set up the local server
Go into the repository and build the docker images:
```console
user@host:/path/to/this/repo$ docker-compose build
```

### Extra step for Windows users
Git for windows may automatically convert files from unix format to dos format, which will lead to failure of initializing the backend. Therefore, we suggest Windows 
users to convert iot-tap-backend/initialize.sh into unix format (LF) manually with tools like Visual Studio Code or dos2unix after running "docker-compose build".


## Option \#2: Use the images we provided
Just simply replace the docker-compose file, and AutoTap will be ready to go:
```console
user@host:/path/to/this/repo$ mv docker-compose-no-build.yml docker-compose.yml
```

# Use AutoTap
Please follow the instructions in [README.md](./README.md) to play with AutoTap and to reproduce the results from our ICSE'19 paper.
