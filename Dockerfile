FROM openjdk:17-slim

WORKDIR /opt/lavalink

# Install native dependencies for Lavalink
RUN apt-get update && apt-get install -y \
    libgcc1 \
    libstdc++6 \
    curl \
    bash \
 && rm -rf /var/lib/apt/lists/*

COPY Lavalink.jar ./Lavalink.jar
COPY application.yml ./application.yml

EXPOSE 2333
ENV _JAVA_OPTIONS="-Xmx512m"

CMD ["java", "-jar", "Lavalink.jar"]