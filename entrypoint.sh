#!/bin/sh

set -eu

model=${INPUT_MODEL:-"small"}

[ -d models ] || mkdir -p models

case "$model" in
  small) [ -f "models/ggml-small.bin" ] || curl -LJ https://huggingface.co/ggerganov/whisper.cpp/resolve/main/ggml-small.bin \
      --output models/ggml-small.bin
      export INPUT_MODEL=models/ggml-small.bin
    ;;
  medium) [ -f "models/ggml-medium.bin" ] || curl -LJ https://huggingface.co/ggerganov/whisper.cpp/resolve/main/ggml-medium.bin \
      --output models/ggml-medium.bin
      export INPUT_MODEL=models/ggml-medium.bin
    ;;
  large) [ -f "models/ggml-large.bin" ] || curl -LJ https://huggingface.co/ggerganov/whisper.cpp/resolve/main/ggml-large.bin \
      --output models/ggml-large.bin
      export INPUT_MODEL=models/ggml-large.bin
    ;;
esac

sh -c "/bin/go-whisper $*"
