#!/bin/bash

set -e

echo "[start-prefect-worker.sh] Running..."

if [[ -z "$ENV" ]]; then
  echo -e "Your ENV must be defined to ride this ride.\n\n\t\t  e.g.\n\n\tproduction  or  testing"
  exit 1
fi

if [ -z "$PREFECT_API_KEY" ] || [ -z "$PREFECT_WORKSPACE_ID" ] || [ -z "$PREFECT_ACCOUNT_ID" ]; then
  echo "PREFECT_API_KEY, PREFECT_WORKSPACE_ID and PREFECT_ACCOUNT_ID must be set"
  exit 1
fi

echo "[start-prefect-worker.sh] Setting up worker profile..."

PREFECT_API_URL=https://api.prefect.cloud/api/accounts/"$PREFECT_ACCOUNT_ID"/workspaces/"$PREFECT_WORKSPACE_ID"

prefect profile create worker
prefect profile use worker
prefect config set PREFECT_LOGGING_LEVEL=DEBUG
prefect config set PREFECT_API_SERVICES_LATE_RUNS_AFTER_SECONDS=1800
prefect config set PREFECT_API_KEY="$PREFECT_API_KEY"
prefect config set PREFECT_API_URL="$PREFECT_API_URL"

WORK_POOL_NAME=demo-${ENV}-work-pool

echo "[start-prefect-worker.sh] Creating work pool $WORK_POOL_NAME (if it doesn't exist)"
prefect work-pool create --type process "$WORK_POOL_NAME" || true

echo "[start-prefect-worker.sh] Starting worker for $WORK_POOL_NAME"
prefect worker start --pool "$WORK_POOL_NAME"