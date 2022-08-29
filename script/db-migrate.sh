#!/bin/bash
set -eu;

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
DEPLOY_ENV=${1:-dev}
DB_SCHEMA_DIR=${SCRIPT_DIR}/../dbschema
echo "DB_SCHEMA_DIR: ${DB_SCHEMA_DIR}"

if ! command -v migrate &> /dev/null
then
  echo '# install migration'
  MIGRATION_VERSION=3.3.11
  wget -cp https://oss.sonatype.org/content/repositories/releases/org/mybatis/mybatis-migrations/${MIGRATION_VERSION}/mybatis-migrations-${MIGRATION_VERSION}-bundle.zip -O mybatis-migrations-${MIGRATION_VERSION}-bundle.zip
  unzip mybatis-migrations-${MIGRATION_VERSION}-bundle.zip -d /usr
  rm -f mybatis-migrations-${MIGRATION_VERSION}-bundle.zip
  echo "export PATH=${PATH}:/usr/mybatis-migrations-${MIGRATION_VERSION}/bin" >> ~/.bash_profile
  # shellcheck disable=SC1090
  source ~/.bash_profile
  echo "PATH: ${PATH}"
fi

# migrate up
echo '# migrate up ...'
cp "${DB_SCHEMA_DIR}"/quarkus/environments/properties.template "${DB_SCHEMA_DIR}/quarkus/environments/${DEPLOY_ENV}".properties
migrate up --quiet --path="${DB_SCHEMA_DIR}"/quarkus/ --env="${DEPLOY_ENV}"
