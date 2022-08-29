#!/bin/bash

set -eu;

mysqlStatusCheck() {
  while ! docker exec "${DB_CONTAINER}" mysql --user="${DB_USER}" --password="${DB_PASSWORD}" --host "${DB_HOST}" -e 'status' &> /dev/null; do
    echo "Waiting for mysql be ready..."
    sleep 1
  done
}

DEPLOY_ENV=${1:-dev}
echo "# setup db for ${DEPLOY_ENV}"

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# shellcheck disable=SC1090
source "${SCRIPT_DIR}"/../dbschema/env-${DEPLOY_ENV}

if [[ -z $(docker ps -aqf "name=${DB_CONTAINER}") ]]; then
  echo "host=${DB_HOST}
port=${DB_PORT}
user=${DB_USER}
password=${DB_PASSWORD}
" >> "${SCRIPT_DIR}"/../dbschema/my.cnf
  # this doesn't work on windows WSL(https://github.com/Microsoft/WSL/issues/81)
  chmod 644 "${SCRIPT_DIR}"/../dbschema/my.cnf
  docker-compose -f "${SCRIPT_DIR}"/../dbschema/docker-compose.yml up -d
  mysqlStatusCheck
fi

# create databases
echo "# create databases"
DB_ARRAY=("${DB_SCHEMA}")
for ((ii = 0; ii < ${#DB_ARRAY[@]}; ii++)) {
  CREATE_DB_STATE="CREATE DATABASE IF NOT EXISTS ${DB_ARRAY[ii]}"
  echo "${CREATE_DB_STATE}"
  docker exec -i "${DB_CONTAINER}" mysql --defaults-extra-file=/etc/mysql/my.cnf -e "${CREATE_DB_STATE}"
}

# migrate tables
echo "# migrate tables"
"${SCRIPT_DIR}"/db-migrate.sh "${DEPLOY_ENV}"

exit 0
