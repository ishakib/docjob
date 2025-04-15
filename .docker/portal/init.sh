#!/bin/sh
set -e

#mkdir \-p /run/nginx

cd /usr/src/portal
if [ "$VITE_ENVIRONMENT" = "dev" ]  || [ -z "${VITE_ENVIRONMENT}" ]
then
 npm run dev
else
  HOST=0.0.0.0 pm2-runtime start yarn --interpreter bash --name web -- preview
fi
