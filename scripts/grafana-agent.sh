#!/bin/sh

# Installing Grafana Agent from Grafana Cloud Caddy integration docs
sudo ARCH=amd64 GCLOUD_STACK_ID="217119" GCLOUD_API_KEY=$1 GCLOUD_API_URL="https://integrations-api-us-central.grafana.net" /bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/grafana/agent/release/production/grafanacloud-install.sh)"