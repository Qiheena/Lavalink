# Lavalink Dockerfile for Render/Railway/Heroku etc
FROM openjdk:17-jdk-alpine

RUN apk add --no-cache curl

WORKDIR /opt/lavalink

# Replace this with the latest Lavalink.jar version as needed
ADD https://github.com/freyacodes/Lavalink/releases/download/4.0.6.1/Lavalink.jar Lavalink.jar

COPY application.yml .

EXPOSE 2333

ENV _JAVA_OPTIONS="-Xmx512m"

CMD ["java", "-jar", "Lavalink.jar"]