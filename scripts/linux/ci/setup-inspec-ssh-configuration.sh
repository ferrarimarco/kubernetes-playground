#!/bin/sh

set -e

SSH_HOST="$1"

echo "Setting environment variables for InSpec to connect to $SSH_HOST via ssh..."

SSH_CONFIG_FILE_PATH="$HOME"/.ssh/config
echo "Current ssh configuration ($SSH_CONFIG_FILE_PATH) $(cat "$SSH_CONFIG_FILE_PATH")"

SSH_CONFIG_FOR_HOST="$(vagrant ssh-config "$SSH_HOST")"
echo "vagrant ssh configuration for $SSH_HOST: $SSH_CONFIG_FOR_HOST"

INSPEC_SSH_USER="$(echo "$SSH_CONFIG_FOR_HOST" | grep -m1 -oP '(?<=User ).*)')"
INSPEC_SSH_HOST="$(echo "$SSH_CONFIG_FOR_HOST" | grep -m1 -oP '(?<=HostName ).*)')"
INSPEC_SSH_PRIVATE_KEY_PATH="$(echo "$SSH_CONFIG_FOR_HOST" | grep -m1 -oP '(?<=IdentityFile ).*)')"
INSPEC_SSH_PORT="$(echo "$SSH_CONFIG_FOR_HOST" | grep -m1 -oP '(?<=Port ).*)')"

echo "Configuration variables for $SSH_HOST: INSPEC_SSH_USER=$INSPEC_SSH_USER, INSPEC_SSH_HOST=$INSPEC_SSH_HOST, INSPEC_SSH_PRIVATE_KEY_PATH=$INSPEC_SSH_PRIVATE_KEY_PATH, INSPEC_SSH_PORT=$INSPEC_SSH_PORT"

export INSPEC_SSH_USER
export INSPEC_SSH_HOST
export INSPEC_SSH_PRIVATE_KEY_PATH
export INSPEC_SSH_PORT

unset SSH_HOST
unset SSH_CONFIG_FILE_PATH

set +e
