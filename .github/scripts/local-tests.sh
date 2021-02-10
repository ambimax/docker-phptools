#!/usr/bin/env bash

set -e

# Tests
scripts/xmllint.sh tests/xmllint
scripts/phplint.sh tests/phplint

# Test defaults
export XMLLINT_DEFAULT_DIR="tests/xmllint" && scripts/xmllint.sh
export PHPLINT_DEFAULT_DIR="tests/phplint" && scripts/phplint.sh
