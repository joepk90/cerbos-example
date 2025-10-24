# Start from the official Cerbos image
FROM ghcr.io/cerbos/cerbos:latest

# Copy configuration and policies
COPY ./config/cerbos.yaml /etc/cerbos/cerbos.yaml
COPY ./policies /policies

# Validate policies at build time (optional but recommended)
# can't run this command using the ghcr.io/cerbos/cerbos - no access to bin/sh
# RUN cerbos compile --config /etc/cerbos/cerbos.yaml --policy-dir /policies

# Expose the HTTP port
EXPOSE 3592

# Start Cerbos
CMD ["server", "--config=/etc/cerbos/cerbos.yaml"]
