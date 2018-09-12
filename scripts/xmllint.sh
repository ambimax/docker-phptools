#!/usr/bin/env bash
#
# @author Tobias Schifftner, ambimax® GmbH
#

function error_exit {
	echo "$1" 1>&2
	exit 1
}

if [ -z $XMLLINT_DEFAULT_DIR ]; then
	XMLLINT_DEFAULT_DIR='.modman'
fi

DEST=${1:-$XMLLINT_DEFAULT_DIR}


if [ ! -d $DEST ] ; then
    error_exit "Invalid dir $DEST"
fi

command_exists () {
    type "$1" &> /dev/null ;
}

TARGET=${DEST%/}
IGNORE_FILES=`find . -type f -name '.xmllint_ignore' | xargs cat`
FIND_IGNORE_PATTERN=$(printf "! -ipath %s " ${IGNORE_FILES})
FILES=`find $TARGET -type f -name '*.xml' ${FIND_IGNORE_PATTERN}`

echo
echo "Checking $DEST"
echo
echo "XMLLint"
echo
echo "Ignored file paths:"
printf '%s\n' "${IGNORE_FILES[@]}"
echo
echo "Checked files:"
printf '%s\n' "${FILES[@]}"
echo


TMP_FILE=/tmp/xmllint.tmp
touch $TMP_FILE;

if command_exists xmllint ; then
    for i in $FILES; do
        md5=($(sha256sum $i));
        if grep -Fxq "$md5" $TMP_FILE; then
            continue;
        fi
            xmllint --noout "$i" || error_exit "Unable to parse file '$i'"
            echo $md5 >> $TMP_FILE
    done
else
    echo "Could not find xmllint. Using PHP instead..."
    for i in $FILES; do
        sha256sum=($(sha256sum $i));
        if grep -Fxq "$sha256sum" $TMP_FILE; then
            continue;
        else
            php -r "if (@simplexml_load_file('$i') === false) exit(1);" || error_exit "Unable to parse file '$i'"
            echo $sha256sum >> $TMP_FILE
        fi
    done
fi

echo "No XML syntax errors detected in $1"