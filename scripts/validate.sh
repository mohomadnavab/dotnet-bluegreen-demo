#!/bin/bash

set -e

echo "validating"

for i in {1..10}; do
  if curl -fs http://localhost:5000; then
    echo "Application is healthy"
    exit 0
    fi

    echo "Waiting for app start"
    sleep 5
done 

echo "app failed health check"
exit 1
