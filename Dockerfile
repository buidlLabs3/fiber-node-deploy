# Fiber node wrapper — generates CKB key on first run if missing
FROM nervos/fiber:0.9.0

# Copy entrypoint wrapper script
COPY entrypoint-wrapper.sh /usr/local/bin/entrypoint-wrapper.sh
RUN chmod +x /usr/local/bin/entrypoint-wrapper.sh

ENTRYPOINT ["/usr/local/bin/entrypoint-wrapper.sh"]
