#!/bin/sh

set -eu

model=${INPUT_MODEL:-"small"}

[ -d models ] || mkdir -p models

case "$model" in
  small) curl -LJ https://huggingface.co/ggerganov/whisper.cpp/resolve/main/ggml-small.bin \
      --output models/ggml-small.bin
      export INPUT_MODEL=models/ggml-small.bin
    ;;
  medium) curl -LJ https://huggingface.co/ggerganov/whisper.cpp/resolve/main/ggml-medium.bin \
      --output models/ggml-medium.bin
      export INPUT_MODEL=models/ggml-medium.bin
    ;;
  large) curl -LJ https://huggingface.co/ggerganov/whisper.cpp/resolve/main/ggml-large.bin \
      --output models/ggml-large.bin
      export INPUT_MODEL=models/ggml-large.bin
    ;;
esac

sh -c "/bin/go-whisper $*"
