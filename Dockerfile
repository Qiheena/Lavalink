
# Base image - optimized for Railway
FROM eclipse-temurin:17-jre-alpine

# Set working directory
WORKDIR /opt/lavalink

# Install native dependencies
RUN apk update && apk add --no-cache \
    libstdc++ \
    curl \
    bash \
    && rm -rf /var/cache/apk/*

# Download Lavalink 3.7.9 (stable version)
RUN curl -L -o Lavalink.jar \
    https://github.com/lavalink-devs/Lavalink/releases/download/3.7.9/Lavalink.jar

# Copy configuration
COPY application.yml ./application.yml

# Create necessary directories
RUN mkdir -p application plugins logs

# Create empty cookies.txt
RUN touch application/cookies.txt

# SIMPLE FIX: Remove conditional COPY, just create plugins directory
RUN mkdir -p plugins

# Health check for Railway
HEALTHCHECK --interval=30s --timeout=10s --start-period=40s --retries=3 \
    CMD curl -f http://localhost:2333/ || exit 1

# Expose port
EXPOSE 2333

# JVM memory optimization for Railway
ENV JAVA_OPTS="-Xmx512m -Xms256m -XX:+UseG1GC -XX:MaxGCPauseMillis=50"
ENV _JAVA_OPTIONS="$JAVA_OPTS"

# Start Lavalink
CMD ["java", "-jar", "Lavalink.jar"]