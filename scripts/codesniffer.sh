#!/usr/bin/env bash
#
# @author Tobias Schifftner, ambimax® GmbH
#

# Get absolute path to main directory
ABSPATH=$(cd "${0%/*}" 2>/dev/null; echo "${PWD}/${0##*/}")
TOOLS_DIR=`dirname "${ABSPATH}"`
BASE_DIR=`dirname "${TOOLS_DIR}"`

function error_exit {
	echo "$1" 1>&2
	exit 1
}

if [ "$1" == "--help" ]; then
	echo "There is no help available"
	exit 0
fi


if [ -z $CODESNIFFER_DEFAULT_DIR ]; then
	CODESNIFFER_DEFAULT_DIR='.modman'
fi

DEST=${1:-$CODESNIFFER_DEFAULT_DIR}

if [ ! -d $DEST ] ; then
    error_exit "Invalid dir $DEST"
fi

# Run in parallel:
# find -L $1 \( -name '*.php' -o -name '*.phtml' \) -print0 | xargs -0 -n 1 -P 20 php -l

WORKSPACE=${DEST%/}
PHPCS_IGNORE=$(find . -type f -name '.phpcs_ignore' | xargs cat | paste -s -d, -)
IGNORE_FILES=`find . -type f -name '.phpcs_ignore' | xargs cat`

echo
echo "CodeSniffer"
echo
echo "Ignored file paths:"
printf '%s\n' "${IGNORE_FILES[@]}"
echo


/tools/phpcs2 --standard=/tools/CodeSniffer/Ecg/ruleset.xml --ignore="${PHPCS_IGNORE}" ${WORKSPACE} || error_exit "CodeSniffer test failed"

echo "No CodeSniffer errors found"