ARG BUILD_FROM
FROM $BUILD_FROM

# Install dependencies for configuration script
RUN apt-get update && apt-get install -y jq iproute2 dos2unix && rm -rf /var/lib/apt/lists/*

# we need to start in /config/bifrost, so we have access to configuration,
# state, certificate, etc
WORKDIR /config/bifrost

# Copy configuration scripts
COPY configure.sh /usr/local/bin/configure.sh
COPY run.sh /run.sh

# Fix line endings (CRLF -> LF) and permissions
RUN dos2unix /run.sh /usr/local/bin/configure.sh && \
    chmod +x /run.sh /usr/local/bin/configure.sh

CMD [ "/run.sh" ]
