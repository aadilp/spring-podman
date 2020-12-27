## Build the project
FROM gradle:6.7.1-jdk11-hotspot AS builder

WORKDIR /app

COPY build.gradle settings.gradle /app/
COPY gradle /app/gradle
COPY src /app/src

RUN gradle clean build -x test

## Build container to run the project
FROM adoptopenjdk:11-jre-hotspot

WORKDIR /app
COPY . /app/

COPY --from=builder /app/build/libs/springpodman*.jar service.jar

EXPOSE 8080

ENTRYPOINT exec java -jar service.jar