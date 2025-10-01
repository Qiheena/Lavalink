# Dockerfile for Lavalink + Spotify Plugin (no external download)

FROM openjdk:17-jdk-alpine

WORKDIR /opt/lavalink

# Copy your manually downloaded Lavalink.jar (must match correct path!)
COPY Lavalink.jar Lavalink.jar

# Copy your application.yml for config/environment (must match correct path!)
COPY application.yml application.yml

# Expose the Lavalink port (default 2333; or use $PORT from env)
EXPOSE 2333

ENV _JAVA_OPTIONS="-Xmx512m"

# Launch Lavalink on container start
CMD ["java", "-jar", "Lavalink.jar"]