#!/usr/bin/env bash

set -e

if [[ "$(docker images -q ambimax/phptools:latest 2> /dev/null)" == "" ]]; then
    echo "Docker image ambimax/phptools is not build yet!"
    exit 1;
fi

# Test in docker container
export DOCKER="docker run --rm -v "$PWD:/travis" -w /travis -i ambimax/phptools"

${DOCKER} /tools/xmllint tests/xmllint
${DOCKER} /tools/phplint tests/phplint
${DOCKER} /tools/codesniffer tests/codesniffer
