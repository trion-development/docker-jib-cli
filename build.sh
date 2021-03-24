#!/bin/bash

git pull --rebase
sed -r -i "s@(.*)JIB_CLI_VERSION=.*@\1JIB_CLI_VERSION=${VERSION}@g" Dockerfile*
git commit -a -m "update to ${VERSION}"
git push 

