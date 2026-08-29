# Fiber node with pre-generated key and config
FROM nervos/fiber:0.9.0

# Copy entrypoint wrapper script
COPY entrypoint-wrapper.sh /usr/local/bin/entrypoint-wrapper.sh
RUN chmod +x /usr/local/bin/entrypoint-wrapper.sh

# Pre-create the config from the template
RUN mkdir -p /fiber/ckb && \
    cp /usr/local/share/fiber/config/testnet/config.yml /fiber/config.yml

# Use shell form so Railway doesn't override entrypoint
CMD ["/usr/local/bin/entrypoint-wrapper.sh", "fnn", "-c", "/fiber/config.yml", "-d", "/fiber"]
