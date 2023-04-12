#!/bin/bash

# Declare constants
readonly BASEDIR="$(cd "$(dirname "$0")" && pwd)"

# Check if .env file exists
if [[ ! -f "$BASEDIR/.env" ]]; then
  printf "Error: .env file not found.\n" >&2
  exit 1
fi

# Source .env file
source "$BASEDIR/.env"

# Declare variables
readonly template_file="$BASEDIR/../bicep/main.bicep"
readonly params_file="$BASEDIR/../bicep/main.params.json"

# Check if python is installed
if ! command -v python3 &> /dev/null; then
  printf "Error: python is not installed.\n" >&2
  exit 1
fi

# Log into tenant if not found
show_tenant=$(az account show)
if ! [[ $show_tenant =~ $tenant_id ]]; then
  if ! az login --tenant "$tenant_id" >/dev/null; then
    printf "Error: Failed to login to tenant.\n" >&2
    exit 1
  fi
fi

# Set correct subscription for deployment scope
if ! az account set --subscription "$subscription_id" >/dev/null; then
  printf "Error: Failed to set subscription.\n" >&2
  exit 1
fi

# Additional variables
deployment_name="cluster-$(whoami)-production-local-$(date +%Y%m%d-%H%M%S)"

# Serialize JSON data
serializedWorkbookData=$(python3 -c "import json; print(json.dumps(json.load(open('$BASEDIR/../workbooks/example.json'))))")

# Initiate deployment with associated bicep file and environment specific parameters file.
az deployment sub create \
  --name "$deployment_name" \
  --location "$location" \
  --template-file "$template_file" \
  --parameters "$params_file" \
  --parameters "workbookData=$serializedWorkbookData"
