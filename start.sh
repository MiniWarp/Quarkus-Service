#!/bin/bash
set -eu;

export DEPLOY_ENV=${1:-dev}
cd "$(dirname "$0")"

echo "# start Quarkus-Service on ${DEPLOY_ENV}"
./script/setup-db.sh "${DEPLOY_ENV}"
docker-compose up -d --build

exit 0
