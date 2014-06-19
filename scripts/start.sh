#!/bin/bash

set -o errexit
set -o pipefail

#export APP_DIR=/var/www/stats.bower.io
export APP_NAME=stats.bower.io
export APP_REDIS=redis-bower
export APP_PM2=scripts/processes.json

if [[ "$HOSTNAME" = "shan.io" ]]; then
  printf "[INFO] redis for $APP_NAME node app starting...\n"
  sudo start $APP_REDIS

  printf "[INFO] $APP_NAME node app starting...\n"
  pm2 restart $APP_NAME

else
  source ./scripts/dev.sh
  export NODE_ENV=development
  redis-server ./scripts/redis.conf
  node-dev index.coffee
fi
