# Usasge -- build.sh [api-name], e.g. build.sh evoke-api or cardsync-api or evoke-partner-api
#!/usr/bin/env bash
docgen build --md --in $1.json --out source/index.html.md
set -o errexit #abort if any command fails
docker pull slatedocs/slate
docker run --rm --name slate -v $(pwd)/build:/srv/slate/build -v $(pwd)/source:/srv/slate/source slatedocs/slate
# zip does not remove entries, so we must delete the zip first
rm -f ./$1.zip
#cd build && zip -r ./$1.zip . && mv ./$1.zip ..
cd build
zip -r ./$1.zip . 
mv ./$1.zip ..
