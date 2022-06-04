#!/bin/sh

# Installing Grafana Agent from Grafana Cloud Caddy integration docs
sudo ARCH=amd64 GCLOUD_PASSWORD=$1 GCLOUD_METRICS_USER=$2 GCLOUD_LOGS_USER=$3 GCLOUD_TRACES_USER=$4 GAGENT_PROFILE=$5 GCLOUD_STACK_ID="217119" GCLOUD_API_KEY=$6 GCLOUD_API_URL="https://integrations-api-us-central.grafana.net" /bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/BrentGruberOrg/install-grafana-agent/main/grafanacloud-install.sh)"