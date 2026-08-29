# Fiber node with auto key generation on first start
FROM nervos/fiber:0.9.0

# Pre-create testnet config from the bundled template
RUN mkdir -p /fiber/ckb && \
    cp /usr/local/share/fiber/config/testnet/config.yml /fiber/config.yml

# Copy entrypoint that generates CKB key, then starts fnn with hardcoded args
COPY entrypoint-wrapper.sh /usr/local/bin/entrypoint-wrapper.sh
RUN chmod +x /usr/local/bin/entrypoint-wrapper.sh

# ENTRYPOINT with full command — Railway cannot inject its own CMD
ENTRYPOINT ["/usr/local/bin/entrypoint-wrapper.sh"]
