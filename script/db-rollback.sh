#!/bin/bash
set -eu;

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
DB_SCHEMA_DIR=${SCRIPT_DIR}/../dbschema
echo "DB_SCHEMA_DIR: ${DB_SCHEMA_DIR}"

TARGET_VERSION=$1
echo "definition schema rollback migration version:$TARGET_VERSION"

# rollback definition
echo '# rollback definition'
cp "${DB_SCHEMA_DIR}"/definition/environments/properties.template "${DB_SCHEMA_DIR}"/definition/environments/"${DEPLOY_ENV}".properties
migrate version "${TARGET_VERSION}" --path="${DB_SCHEMA_DIR}"/definition/ --env="${DEPLOY_ENV}"
