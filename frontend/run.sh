#! /usr/bin/env bash

sed -i "s/API_SERVER/$API_NAME/g" /taiga/conf.json
sed -i "s/API_PORT/$API_PORT/g" /taiga/conf.json
sed -i "s/API_PROTOCOL/$API_PROTOCOL/g" /taiga/conf.json


nginx -g "daemon off;"
