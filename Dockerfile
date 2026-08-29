# Fiber node with pre-generated key and config
FROM nervos/fiber:0.9.0

# Pre-create the config from the template
RUN mkdir -p /fiber/ckb && \
    cp /usr/local/share/fiber/config/testnet/config.yml /fiber/config.yml

# Use the original Fiber entrypoint but set env vars for config and key password
ENV FIBER_CONFIG=/fiber/config.yml
ENV FIBER_HOME=/fiber
