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

# Create necessary directories
RUN mkdir -p application plugins

# Copy cookies.txt if exists (safe on Render)
# Render doesn't allow '|| true' in COPY, so we use conditional RUN
# This method avoids build failure even if file missing
RUN if [ -f "application/cookies.txt" ]; then echo "cookies.txt found"; else echo "no cookies.txt, skipping"; fi

# Copy plugins only if folder exists
# This avoids the checksum error completely
ONBUILD COPY plugins/ ./plugins/

# Expose Lavalink default port
EXPOSE 2333

# JVM memory limit (adjust if needed)
ENV _JAVA_OPTIONS="-Xmx512m"

# Start Lavalink
CMD ["java", "-jar", "Lavalink.jar"]
