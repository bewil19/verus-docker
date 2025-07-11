#!/bin/bash

set -e

# Check marker file to determine if fetch has already been completed
BOOTSTRAP_DONE_FILE=".bootstrap_done"

if [ ! -f "$BOOTSTRAP_DONE_FILE" ]; then
    echo "[*] Running fetch-params and fetch-bootstrap for the first time..."

    ./fetch-params

    # Automate fetch-bootstrap.sh non-interactively
    echo -e "\n1\n1" | ./fetch-bootstrap

    # Create marker to skip fetch on future runs
    touch "$BOOTSTRAP_DONE_FILE"

    echo "[*] Bootstrap completed. Marker file created."
else
    echo "[*] Bootstrap already completed previously. Skipping fetch commands."
fi

# Build verusd command line arguments
VRSC_ARGS=""

if [[ -n "${VERUSD_RPC_USER}" ]]; then
    VRSC_ARGS+=" -rpcuser=${VERUSD_RPC_USER}"
fi
if [[ -n "${VERUSD_RPC_PASSWORD}" ]]; then
    VRSC_ARGS+=" -rpcpassword=${VERUSD_RPC_PASSWORD}"
fi
if [[ -n "${VERUSD_RPC_PORT}" ]]; then
    VRSC_ARGS+=" -rpcport=${VERUSD_RPC_PORT}"
fi

# Start the verusd daemon
./verusd -printtoconsole $VRSC_ARGS
