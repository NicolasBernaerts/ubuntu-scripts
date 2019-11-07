#!/bin/bash
# install sshfs-mount environment

# get parameters
CONFIG_FILE="$1"
CONFIG_INDEX="$2"

# test parameters
[ ! -f "${CONFIG_FILE}" ] && { echo "${CONFIG_FILE} doesn't exist"; exit 1; }
[ "${CONFIG_INDEX}" = "" ] && { echo "Configuration index not provided"; exit 1; }

# install sshfs
echo "install packages"
sudo apt-get -y install sshfs

# read configuration
NAME=$(grep "^name=" "${CONFIG_FILE}" | cut -d'=' -f2)
LABEL=$(grep "^label=" "${CONFIG_FILE}" | cut -d'=' -f2)
ICON=$(grep "^icon=" "${CONFIG_FILE}" | cut -d'=' -f2)
SERVER_ACCOUNT=$(grep "^account=" "${CONFIG_FILE}" | cut -d'=' -f2)
SERVER_LABEL=$(grep "^${CONFIG_INDEX}-label=" "${CONFIG_FILE}" | cut -d'=' -f2)
SERVER_ADDRESS=$(grep "^${CONFIG_INDEX}-address=" "${CONFIG_FILE}" | cut -d'=' -f2)
SERVER_PORT=$(grep "^${CONFIG_INDEX}-port=" "${CONFIG_FILE}" | cut -d'=' -f2)

# check configuration data

# set configuration file
echo "set configuration file"
SSHFS_CONFIG="$HOME/.config/sshfs-${NAME}.conf"
cat "${CONFIG_FILE}" > "${SSHFS_CONFIG}"

# download and install script
echo "install script"
# wget ...
chmod +x ./sshfs-mount
sudo cp ./sshfs-mount /usr/local/bin/sshfs-mount

# download and install desktop file
echo "install launcher for ${NAME}"
SSHFS_LAUNCHER="$HOME/.local/share/applications/sshfs-${NAME}.desktop"
# wget ...
cat ./sshfs-mount.desktop | sed "s|NAME|${NAME}|g" | sed "s|LABEL|${LABEL}|g" | sed "s|ICON|${ICON}|g" > "${SSHFS_LAUNCHER}"
chmod +x "${SSHFS_LAUNCHER}"

# if needed, add ServerAliveInterval to SSH config
echo "set SSH config"
INTERVAL=$(grep "ServerAliveInterval" "$HOME/.ssh/config")
[ "${INTERVAL}" = "" ] && echo "ServerAliveInterval 15" >> "$HOME/.ssh/config"

# if needed, generate keys
echo "generate SSH keys"
[ ! -f "$HOME/.ssh/id_rsa" ] && ssh-keygen -t rsa

# upload public key to SSH server
echo "upload public key to server"
ssh-copy-id -p "${SERVER_PORT}" "${SERVER_ACCOUNT}@${SERVER_ADDRESS}"

# test the connexion
echo "first connexion on ${SERVER_LABEL}"
ssh -v -p "${SERVER_PORT}" "${SERVER_ACCOUNT}@${SERVER_ADDRESS}"
