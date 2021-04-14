#!/usr/bin/env bash
set -o errexit #abort if any command fails
docker pull slatedocs/slate
docker run --rm --name slate -v $(pwd)/build:/srv/slate/build -v $(pwd)/source:/srv/slate/source slatedocs/slate
