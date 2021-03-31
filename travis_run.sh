#!/bin/bash

FILE="`pwd`/metadata.yaml"
BEARER=$(curl --url https://${LEANIX_HOST}/services/mtm/v1/oauth2/token -u apitoken:${LEANIX_TOKEN} --data grant_type=client_credentials | jq -r '.access_token') 
echo $(curl -H "Authorization: Bearer $BEARER" -H 'Content-Type: multipart/form-data' -F manifest="@$FILE" -F 'data={"version": "1.0.0", "stage": "dev"}' $URL)
