#!/bin/bash

KRATOS_URL=http://192.168.0.53:4433/self-service

FLOW_ID=$(curl -H 'Content-Type: application/json' -H 'Accept: application/json' ${KRATOS_URL}/login/api | jq -r '.id')

read -p "E-Mail ? " USERNAME
read -p "Password ? " -s PASSWORD

SESSION_TOKEN=$(curl -X POST -H 'Content-Type: application/json' -H 'Accept: application/json' -d '{"method":"password","identifier":"'${USERNAME}'","password":"'${PASSWORD}'"}' "${KRATOS_URL}/login?flow=${FLOW_ID}" | jq -r '.session_token')

echo $SESSION_TOKEN

exit

curl -X DELETE -H 'Content-Type: application/json' -d '{"session_token":"'${SESSION_TOKEN}'"}' ${KRATOS_URL}/logout/api