# Usasge -- build.sh [api-name], e.g. build.sh evoke-api or cardsync-api
#!/usr/bin/env bash
set -o errexit #abort if any command fails
docker pull slatedocs/slate
docker run --rm --name slate -v $(pwd)/build:/srv/slate/build -v $(pwd)/source:/srv/slate/source slatedocs/slate
# zip does not remove entries, so we must delete the zip first
rm -f ./$1.zip
zip -r ./$1.zip build
