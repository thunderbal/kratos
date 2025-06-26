#!/bin/bash

KRATOS_URL=http://192.168.0.53:4433/self-service

FLOW_ID=$(curl -H 'Content-Type: application/json' -H 'Accept: application/json' ${KRATOS_URL}/registration/api | jq -r '.id')

read -p "E-Mail ? " USERNAME
read -p "Password ? " -s PASSWORD

curl -X POST -H 'Content-Type: application/json' -H 'Accept: application/json' -d '{"method":"password","traits.email":"'${USERNAME}'","password":"'${PASSWORD}'"}' "${KRATOS_URL}/registration?flow=${FLOW_ID}" | jq '.'