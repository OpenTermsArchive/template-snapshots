#!/bin/bash
set -e

INSTANCE_NAME=$1
INSTANCE_MAINTAINER=$2

usage() {
  echo "Usage: $0 \$INSTANCE_NAME \"\$INSTANCE_MAINTAINER\""
  exit 1
}

if ! test $INSTANCE_NAME || ! test "$INSTANCE_MAINTAINER"
then
  usage
fi

echo "Replacing \${instanceName} and \${instanceMaintainer} by "$INSTANCE_NAME" in files..."
# Use intermediate backup files (`-i`) with a weird syntax due to lack of portable 'no backup' option. See https://stackoverflow.com/q/5694228/594053.
# Credit to https://github.com/openfisca/country-template/blob/master/bootstrap.sh
sed -i.template "s|\${instanceName}|$INSTANCE_NAME|g" README.template.md
sed -i.template "s|\${instanceMaintainer}|$INSTANCE_MAINTAINER|g" README.template.md
find . -name "*.template" -type f -delete

echo "Replacing README"
rm README.md
mv README.template.md README.md

echo "🎉 You're all done, congratulations"
rm init.sh
