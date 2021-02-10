#!/usr/bin/env bash
#
# @author Tobias Schifftner, ambimax® GmbH
#

set -e

# ----------------------------------
# Colors
# ----------------------------------
NOCOLOR='\033[0m'
RED='\033[0;31m'
GREEN='\033[0;32m'

function error_exit {
	echo -e "${RED}${1}${NOCOLOR}" 1>&2
	exit 1
}

function success_message {
	echo -e "${GREEN}${1}${NOCOLOR}"
}

if [ -z "$CODESNIFFER_DEFAULT_DIR" ]; then
	CODESNIFFER_DEFAULT_DIR='.modman'
fi

DEST=${1:-$CODESNIFFER_DEFAULT_DIR}

if [ ! -d "$DEST" ] ; then
    error_exit "Invalid dir $DEST"
fi

# Run in parallel:
# find -L $1 \( -name '*.php' -o -name '*.phtml' \) -print0 | xargs -0 -n 1 -P 20 php -l

WORKSPACE=${DEST%/}
PHPCS_IGNORE=$(find . -type f -name '.phpcs_ignore' -print0 | xargs cat | paste -s -d, -)
IGNORE_FILES=$(find . -type f -name '.phpcs_ignore' -print0 | xargs cat)

echo
echo "CodeSniffer"
echo
echo "Ignored file paths:"
printf '%s\n' "${IGNORE_FILES[@]}"
echo


/tools/phpcs2 --standard=/tools/CodeSniffer/Ecg/ruleset.xml --ignore="${PHPCS_IGNORE}" ${WORKSPACE} || error_exit "CodeSniffer test failed"

success_message "No CodeSniffer errors found"
