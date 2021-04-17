#!/usr/bin/env bash
set -o errexit #abort if any command fails
docker pull slatedocs/slate
docker run --rm --name slate -v $(pwd)/build:/srv/slate/build -v $(pwd)/source:/srv/slate/source slatedocs/slate
# zip does not remove entries, so we must delete the zip first
rm -f ./cardsync-api.zip
zip -r cardsync-api build
