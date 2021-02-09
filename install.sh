#!/usr/bin/env bash

# ----------------------------------
# Colors
# ----------------------------------
NOCOLOR='\033[0m'
RED='\033[0;31m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
LIGHTGRAY='\033[0;37m'
DARKGRAY='\033[1;30m'
LIGHTRED='\033[1;31m'
LIGHTGREEN='\033[1;32m'
YELLOW='\033[1;33m'
LIGHTBLUE='\033[1;34m'
LIGHTPURPLE='\033[1;35m'
LIGHTCYAN='\033[1;36m'
WHITE='\033[1;37m'


error_exit() {
  echo -e "\n\n${RED}${1}${NOCOLOR}\n\n"
  exit 1;
}

###############################################
### Handle cli parameters
###############################################
PARAMS=""
while (( "$#" )); do
  case "$1" in
    -u|--url)
      URL="$2"
      shift
      ;;
    -p|--path)
      DEST="$2"
      shift
      ;;
    -h|--sha256sum)
      HASH="$2"
      shift
      ;;
    -*|--*=) # unsupported flags
      echo "Error: Unsupported flag $1" >&2
      exit 1
      ;;
    *) # preserve positional arguments
      PARAMS="$PARAMS $1"
      shift
      ;;
  esac
done


###############################################
### Input validation
###############################################
if [ -z "${DEST}" ]; then
    error_exit "Path not defined";
fi

if [ -z "${URL}" ]; then
    error_exit "Url not defined";
fi

if [ -z "${HASH}" ]; then
    error_exit "Hash not defined";
fi


###############################################
### Download files and check hash
###############################################
echo -n "${DEST}"

# Ensure dest directory
DIR=${DEST%/*}
if [ ! -d "$DIR" ]; then
    mkdir -p "$DIR" || error_exit "$DIR not creatable"
fi

# Download file
curl --compressed --location --silent --show-error --output "${DEST}" "${URL}"

# Get file hash
FILE_HASH=$(sha256sum "${DEST}" | awk '{ print $1 }')

# Get file size
FILE_SIZE=$(wc -c < "${DEST}")

# Validate file
if [ ! -f "$DEST" ]; then
    error_exit "File ${DEST} not downloaded"
fi

if [ "$FILE_SIZE" -lt 2 ]; then
    error_exit "File ${DEST} is empty"
fi

if [ "${FILE_HASH}" != "${HASH}" ]; then
    error_exit "File has wrong hash!\n\n${NOCOLOR}${DEST}\n\n${GREEN}${HASH} (expected)\n${RED}${FILE_HASH} (received)"
fi

# Make executable
chmod +x "${DEST}"


###############################################
### Done
###############################################
echo -e "   ${GREEN}OK${NOCOLOR}"
