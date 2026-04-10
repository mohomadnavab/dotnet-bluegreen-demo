#!/bin/bash
set -e

APP_DIR=/home/ubuntu/app

cd $APP_DIR

# stop old process
pkill -f dotnet || true

# start application
export ASPNETCORE_URLS=http://0.0.0.0:80

nohup dotnet out/dotnet-bluegreen-demo.dll > app.log 2>&1 &
