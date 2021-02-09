#!/usr/bin/env bash

# Tests
scripts/xmllint.sh .travis/xmllint
scripts/phplint.sh .travis/phplint

# Test defaults
export XMLLINT_DEFAULT_DIR=".travis/xmllint" && scripts/xmllint.sh
export PHPLINT_DEFAULT_DIR=".travis/phplint" && scripts/phplint.sh
