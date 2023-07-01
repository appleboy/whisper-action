FROM ghcr.io/appleboy/go-whisper:0.0.4

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
