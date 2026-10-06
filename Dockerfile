FROM golang:1.26.8-alpine AS build
RUN apk add --no-cache make gcc g++
WORKDIR /src
ADD --checksum=sha256:8d6b88f6cf1f5e872c1a012091ce206bd2738b1892f7b118b3e01d29e677b466 https://codeload.github.com/appleboy/go-whisper/tar.gz/2c4ee252d1347e7144adaf7fcb34734f2ddebd5e /tmp/source.tar.gz
ADD --checksum=sha256:76f94b195061a8336591a8a8e22a70385621cb513b2db956514cbb8669d21be6 https://codeload.github.com/appleboy/whisper.cpp/tar.gz/1dd0f53753abe35339659b610dbf18ce8cf9e852 /tmp/whisper.tar.gz
RUN tar xzf /tmp/source.tar.gz --strip-components=1 -C /src && mkdir -p third_party/whisper.cpp && tar xzf /tmp/whisper.tar.gz --strip-components=1 -C third_party/whisper.cpp && make dependency UNAME_M=generic && GOMAXPROCS=2 make build VERSION=1.3.0 GOFLAGS='-p=1'
FROM ubuntu:24.04
RUN apt-get update && apt-get install -y --no-install-recommends ca-certificates curl ffmpeg libsndfile1 libatomic1 python3 python3-venv && rm -rf /var/lib/apt/lists/*
RUN python3 -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"
ADD --checksum=sha256:da8939bb536ede1ce4f8e1140f3a7dc4eb93409494a03cd6dd8d70e7fbe2b5ba https://codeload.github.com/dunossauro/videomaker-helper/tar.gz/1fd99ecf4d389bcd14e6d3ef0a0b61be4490576f /tmp/helper.tar.gz
# Only cut-silences is used by the action. Avoid the helper's unrelated, obsolete PyTorch transcription dependencies.
RUN python -m pip install --no-cache-dir --upgrade pip setuptools && python -m pip install --no-cache-dir --no-deps /tmp/helper.tar.gz && python -m pip install --no-cache-dir pydub 'typer>=0.9,<0.10' 'click<8.2' loguru tinydb rich pedalboard parsel 'moviepy==2.0.0.dev2' appdirs matplotlib librosa && rm /tmp/helper.tar.gz
COPY --from=build /src/bin/go-whisper /bin/go-whisper
WORKDIR /app
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
