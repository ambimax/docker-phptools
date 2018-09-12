#!/usr/bin/env bash
#
# @author Tobias Schifftner, ambimax® GmbH
#

function error_exit {
	echo "$1" 1>&2
	exit 1
}

if [ -z $PHPLINT_DEFAULT_DIR ]; then
	PHPLINT_DEFAULT_DIR='.modman'
fi

DEST=${1:-$PHPLINT_DEFAULT_DIR}

if [ ! -d $DEST ] ; then
    error_exit "Invalid dir $DEST"
fi

# Run in parallel:
# find -L $DEST \( -name '*.php' -o -name '*.phtml' \) -print0 | xargs -0 -n 1 -P 20 php -l

TARGET=${DEST%/}
IGNORE_FILES=`find . -type f -name '.phplint_ignore' | xargs cat`
FIND_IGNORE_PATTERN=$(printf "! -ipath %s " ${IGNORE_FILES})
FILES=`find $TARGET -type f \( -name '*.php' -o -name '*.phtml' \) ${FIND_IGNORE_PATTERN}`

echo
echo "PHPLint"
echo
echo "Ignored file paths:"
printf '%s\n' "${IGNORE_FILES[@]}"
echo
echo "Checked files:"
printf '%s\n' "${FILES[@]}"
echo

TMP_FILE=/tmp/phplint.tmp
touch $TMP_FILE;

for i in $FILES; do
    sha256sum=($(sha256sum $i));
    if grep -Fxq "$sha256sum" $TMP_FILE; then
        continue
    fi

    php -l "$i" >/dev/null 2>&1 || error_exit "Unable to parse file '$i'"
    echo $sha256sum >> $TMP_FILE
done

echo "No PHP syntax errors detected in $DEST"