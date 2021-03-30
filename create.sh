#!/bin/bash

TEMPLATE="./template.cnf"
OUTPUT_DIR="./output"
TMP_DIR=$(mktemp -d)
DOMAIN_INPUT=$1
DOMAIN_NAME="*.${DOMAIN_INPUT}"

if [ -z "$DOMAIN_INPUT" ]; then
  echo "Argument not present."
  echo "Useage $0 acab.google.com"

  exit 99
fi

echo "Generating input config "
cat $TEMPLATE | sed "s/ACAB/${DOMAIN_NAME}/" >$TMP_DIR/${DOMAIN_INPUT}.cnf

echo "Generating key request for $DOMAIN_NAME"
openssl req -nodes -config $TMP_DIR/${DOMAIN_INPUT}.cnf -new -newkey rsa:4096 -keyout $OUTPUT_DIR/${DOMAIN_INPUT}.key -sha256 -out $OUTPUT_DIR/${DOMAIN_INPUT}.csr
