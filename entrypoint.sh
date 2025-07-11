#!/bin/bash

set -e

./fetch-params

# === Automate fetch-bootstrap.sh non-interactively ===
echo -e "\n1\n1" | ./fetch-bootstrap.sh

# Build verusd command line arguments
VRSC_ARGS=""

if [[ -n "${VERUSD_RPC_USER}" ]]; then VRSC_ARGS+=" -rpcuser=${VERUSD_RPC_USER}"; fi
if [[ -n "${VERUSD_RPC_PASSWORD}" ]];then VRSC_ARGS+=" -rpcpassword=${VERUSD_RPC_PASSWORD}";fi
if [[ -n "${VERUSD_RPC_PORT}" ]];then VRSC_ARGS+=" -rpcport=${VERUSD_RPC_PORT}";fi

# Start the verusd daemon
./verusd -printtoconsole $VRSC_ARGS