# whisper-action

Speech-to-Text using [ggerganov/whisper.cpp](https://github.com/ggerganov/whisper.cpp) for [GitHub Action](https://github.com/features/actions).

## Inputs variables

See [action.yml](./action.yml) for more detailed information.

| Variable         | Description                                                  | Default |
|------------------|--------------------------------------------------------------|---------|
| model            | public whisper model. (available: small, medium and large)   | small   |
| audio_path       | Audio Path.                                                  |         |
| output_folder    | output folder.                                               |         |
| output_format    | output format, support txt, srt, csv.                        | txt     |
| output_filename  | output filename.                                             |         |
| debug            | enable debug mode.                                           |         |
| print_progress   | print progress.                                              | true    |
| print_segment    | print segment.                                               |         |
| youtube_url      | youtube url                                                  |         |
