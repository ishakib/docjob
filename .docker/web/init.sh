#!/bin/sh
set -e

#mkdir \-p /run/nginx

cd /usr/src/web
if [ "$ENVIRONMENT" = "local" ]  || [ -z "${ENVIRONMENT}" ]
then
 npm run dev
else
  npm run build
  pm2-runtime start npm -- start
fi