#!/bin/bash

### Extract the npm dependencies
license-checker --json > dependencies.json 

### Get a bearer token
AUTH_URL=https://${LEANIX_HOST}/services/mtm/v1/oauth2/token
BEARER=$(curl ${AUTH_URL} -u apitoken:${LEANIX_TOKEN} --data grant_type=client_credentials | jq -r '.access_token') 

### Call the CICD connector
URL=https://${LEANIX_HOST}/services/cicd-connector/v2/deployment
MANIFEST="`pwd`/metadata.yaml"
DEPENDENCIES="`pwd`/dependencies.json"

curl -X POST \
  -H "Authorization: Bearer $BEARER"\
  -H "Content-Type: multipart/form-data" \
  -F manifest="@$MANIFEST" \
  -F dependencies="@$DEPENDENCIES" \
  -F 'data={
  "version": "1.0.1",
  "stage": "dev",
  "dependencyManager": "NPM"
}' $URL
echo $?
