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

## Usage

Donwload Youtube video and transcript it.

```yaml
jobs:
  youtube-eng-video:
    name: transcript english video
    runs-on: ubuntu-latest
    steps:
    - name: checkout
      uses: actions/checkout@v3

    - name: speech to text
      uses: appleboy/whisper-action@v0.0.1
      with:
        model: small
        youtube_url: https://www.youtube.com/watch?v=pTCxXZh6VyE
        output_format: srt
        output_folder: youtube
        print_segment: true
        debug: true

    - name: git push changes
      uses: appleboy/git-push-action@v0.0.2
      with:
        branch: main
        commit: true
        commit_message: "[skip ci] Upload changes"
        remote: git@github.com:appleboy/whisper-action.git
        ssh_key: ${{ secrets.DEPLOY_KEY }}
        rebase: true
```

See the output file in youtube folder.
