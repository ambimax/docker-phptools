#!/usr/bin/env bash

if [[ "$(docker images -q ambimax/phptools:latest 2> /dev/null)" == "" ]]; then
    echo "Docker image ambimax/phptools is not build yet!"
    exit 1;
fi

# Test in docker container
export DOCKER="docker run --rm -v "$PWD:/travis" -w /travis -i ambimax/phptools"

${DOCKER} /tools/xmllint .travis/xmllint
${DOCKER} /tools/phplint .travis/phplint
${DOCKER} /tools/codesniffer .travis/codesniffer
