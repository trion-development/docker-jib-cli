#!/bin/bash
set -Eeuxo pipefail

if [ -z "${VERSION}" ] ; then
    echo 'Please provide version as environment, f.e. VERSION=1.0.0.BETA1'
    exit 1
fi

git pull --rebase
sed -r -i "s@(.*)JIB_CLI_VERSION=.*@\1JIB_CLI_VERSION=${VERSION}@g" Dockerfile*
git commit -a -m "update to ${VERSION}"
git push 

