# Base image
FROM openjdk:17-slim

# Working directory
WORKDIR /opt/lavalink

# Install native dependencies
RUN apt-get update && apt-get install -y \
    libgcc1 \
    libstdc++6 \
    curl \
    bash \
    && rm -rf /var/lib/apt/lists/*

# Copy Lavalink jar and config
COPY Lavalink.jar ./Lavalink.jar
COPY application.yml ./application.yml

# Copy YouTube cookies
COPY application/cookies.txt ./application/cookies.txt

# Optional: plugins folder (Spotify etc.)
COPY plugins/ ./plugins/
#=======
#COPY plugins/ ./plugins/
#>>>>>>> 69846a5 (some update)

# Expose default Lavalink port
EXPOSE 2333

# JVM memory limit (adjust if needed)
ENV _JAVA_OPTIONS="-Xmx512m"

# Launch Lavalink
CMD ["java", "-jar", "Lavalink.jar"]
