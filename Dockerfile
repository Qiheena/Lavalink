# Base image
FROM openjdk:17-slim

# Set working directory
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

# Copy YouTube cookies if present
# (Safe even if file missing)
RUN mkdir -p application
COPY application/cookies.txt ./application/cookies.txt 2>/dev/null || true

# Optional: Copy plugins folder if it exists
# (Prevents error if folder not found)
RUN mkdir -p plugins
COPY plugins/ ./plugins/ 2>/dev/null || true

# Expose Lavalink default port
EXPOSE 2333

# Set JVM memory limit (adjust if needed)
ENV _JAVA_OPTIONS="-Xmx512m"

# Start Lavalink
CMD ["java", "-jar", "Lavalink.jar"]
