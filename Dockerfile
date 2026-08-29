# Fiber node with auto key generation
FROM nervos/fiber:0.9.0

COPY entrypoint-wrapper.sh /usr/local/bin/entrypoint-wrapper.sh
RUN chmod +x /usr/local/bin/entrypoint-wrapper.sh

# Pre-create config from template
RUN mkdir -p /fiber/ckb && \
    cp /usr/local/share/fiber/config/testnet/config.yml /fiber/config.yml

# Override entrypoint to generate key on first run
ENTRYPOINT ["/usr/local/bin/entrypoint-wrapper.sh"]
