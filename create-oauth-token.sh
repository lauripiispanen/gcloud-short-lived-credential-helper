#!/usr/bin/env bash

TOKEN=$(gcloud auth print-access-token)
ACCOUNT_EMAIL_OR_UNIQUEID=$1


if [[ -z "$1" ]]
then
  echo "Please provide service account email or unique id"
  echo ""
  echo "To see which service accounts are available: gcloud iam service-accounts list"
  exit 1
else
  access_token_regex='"accessToken": "([^"]*)'

  lifetime=${2:-300s}
  response=$(curl -X POST -H "Authorization: Bearer $TOKEN" -H "Content-Type: application/json" \
	-d "{\"delegates\": [], \"scope\": [ \"https://www.googleapis.com/auth/cloud-platform\"], \"lifetime\":\"$lifetime\"}" \
	"https://iamcredentials.googleapis.com/v1/projects/-/serviceAccounts/$ACCOUNT_EMAIL_OR_UNIQUEID:generateAccessToken")

  if [[ $response =~ $access_token_regex ]]
  then
    echo ${BASH_REMATCH[1]}
    exit 1
  else
    echo $response
  fi
  
fi
