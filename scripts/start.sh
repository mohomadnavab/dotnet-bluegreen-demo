#!/bin/bash
set -e

cd /home/ubuntu/app

# stop old process
pkill -f dotnet || true

nohup dotnet dotnet-bluegreen-demo.dll > app.log 2>&1 &

sleep 10
