# Spring Podman

A super simple Spring Boot containerization example using Podman and Buildah.

## Prerequisites

- [Podman](https://podman.io)
- [Buildah](https://buildah.io)

## Build

In project root, run `sudo ./buildah-build-service.sh`

## Run

Run `sudo podman run -p 8080:8080 --name service spring-podman`

The application in its current form does not expose any endpoints, so you will see a 404 error on `localhost:8080` which is expected behaviour.

Running `sudo podman ps` should display an output like this:

```
CONTAINER ID  IMAGE                           COMMAND    CREATED         STATUS             PORTS                   NAMES
abcd1234ab12  localhost/spring-podman:latest  /bin/bash  22 seconds ago  Up 19 seconds ago  0.0.0.0:8080->8080/tcp  service
```

## Contact

Feel free to get in touch with me [@AadilPitafi](https://twitter.com/AadilPitafi)
