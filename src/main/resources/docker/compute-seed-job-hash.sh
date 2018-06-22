#!/usr/bin/env bash

SCRIPT_PATH=$1
APPROVAL_PATH=$2

# Compute job.groovy script hash and replace placeholder in scriptApproval.xml.
SCRIPT_HASH=$((echo -n 'groovy:'; cat ${SCRIPT_PATH}) | sha1sum | awk '{print $1}')
sed -ie "s/\${job\.groovy\.hash}/${SCRIPT_HASH}/g" ${APPROVAL_PATH}
unset SCRIPT_HASH
