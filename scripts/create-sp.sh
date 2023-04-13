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

# Log into tenant if not found
show_tenant=$(az account show)
if ! [[ $show_tenant =~ $tenant_id ]]; then
  if ! az login --tenant "$tenant_id" >/dev/null; then
    printf "Error: Failed to login to tenant.\n" >&2
    exit 1
  fi
fi

# Initiate creation of Service Principal with Contributor permissions on our chosen Subscription.
az ad sp create-for-rbac \
  --name "$service_principal_name" \
  --role "contributor" \
  --scopes "/subscriptions/$subscription_id" \
  --sdk-auth