#!/usr/bin/env bash

## Build the project
builder=$(buildah from gradle:6.7.1-jdk11-hotspot)

buildah config --workingdir='/app' $builder

buildah copy $builder build.gradle settings.gradle /app/
buildah copy $builder src /app/src
buildah copy $builder gradle /app/gradle

buildah run $builder -- gradle clean build -x test

## Build container to run the project
jdkcontainer=$(buildah from adoptopenjdk:11-jre-hotspot)

buildah config --workingdir='/app' $jdkcontainer
buildah copy $jdkcontainer . /app/

buildermnt=$(buildah mount $builder)

buildah copy $jdkcontainer $buildermnt/app/build/libs/springpodman*.jar service.jar

buildah unmount $buildermnt

buildah config --port 8080 $jdkcontainer

buildah config --entrypoint 'exec java -jar service.jar' $jdkcontainer

buildah commit $jdkcontainer spring-podman