FROM amd64/debian:stable-slim
ENV GOTIFY_SERVER_PORT="80"
WORKDIR /usr/src/app/gotify
RUN export DEBIAN_FRONTEND=noninteractive && apt-get update && apt-get install -yq \
  tzdata \
  curl \
  ca-certificates \
  && rm -rf /var/lib/apt/lists/*
ADD app/gotify-app /usr/src/app/gotify/
HEALTHCHECK --interval=30s --timeout=5s --start-period=5s CMD curl --fail http://localhost:$GOTIFY_SERVER_PORT/health || exit 1
EXPOSE 80
ENTRYPOINT ["./gotify-app"]
