#!/bin/bash
# install sshfs-mount environment

# get parameters
CONFIG_FILE="$1"
CONFIG_INDEX="$2"

# check parameters
[ "${CONFIG_FILE}" = "" ] && { echo "Configuration file not provided"; exit 1; }
[ "${CONFIG_INDEX}" = "" ] && { echo "Configuration index not provided"; exit 1; }
[ ! -f "${CONFIG_FILE}" ] && { echo "${CONFIG_FILE} doesn't exist"; exit 1; }

# read configuration
NAME=$(grep "^name=" "${CONFIG_FILE}" | cut -d'=' -f2)
LABEL=$(grep "^label=" "${CONFIG_FILE}" | cut -d'=' -f2)
ICON=$(grep "^icon=" "${CONFIG_FILE}" | cut -d'=' -f2)
SERVER_ACCOUNT=$(grep "^account=" "${CONFIG_FILE}" | cut -d'=' -f2)
SERVER_LABEL=$(grep "^${CONFIG_INDEX}-label=" "${CONFIG_FILE}" | cut -d'=' -f2)
SERVER_ADDRESS=$(grep "^${CONFIG_INDEX}-address=" "${CONFIG_FILE}" | cut -d'=' -f2)
SERVER_PORT=$(grep "^${CONFIG_INDEX}-port=" "${CONFIG_FILE}" | cut -d'=' -f2)

# check configuration data
[ "${ICON}" = "" ] && ICON="server"
[ "${SERVER_PORT}" = "" ] && SERVER_PORT=22
[ "${NAME}" = "" ] && { echo "Ressource name not defined in ${CONFIG_FILE}"; exit 1; }
[ "${LABEL}" = "" ] && { echo "Ressource label not defined in ${CONFIG_FILE}"; exit 1; }
[ "${SERVER_ACCOUNT}" = "" ] && { echo "Server account not defined in ${CONFIG_FILE}"; exit 1; }
[ "${SERVER_ADDRESS}" = "" ] && { echo "Server URL not defined for index ${CONFIG_INDEX}"; exit 1; }

# install sshfs
echo "install packages"
sudo apt-get -y install sshfs

# set configuration file
echo "set configuration file"
SSHFS_CONFIG="$HOME/.config/sshfs-${NAME}.conf"
cat "${CONFIG_FILE}" > "${SSHFS_CONFIG}"

# download and install script
echo "install script"
wget https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/sshfs/sshfs-mount
chmod +x ./sshfs-mount
sudo cp ./sshfs-mount /usr/local/bin/sshfs-mount

# download and install desktop file
echo "install launcher for ${NAME}"
SSHFS_LAUNCHER="$HOME/.local/share/applications/sshfs-${NAME}.desktop"
wget https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/sshfs/sshfs-mount.desktop
cat ./sshfs-mount.desktop | sed "s|NAME|${NAME}|g" | sed "s|LABEL|${LABEL}|g" | sed "s|ICON|${ICON}|g" > "${SSHFS_LAUNCHER}"
chmod +x "${SSHFS_LAUNCHER}"

# setup SSH config for SSHFS auto-mmount
echo "set SSH config"
INTERVAL=$(grep "ServerAliveInterval" "$HOME/.ssh/config")
[ "${INTERVAL}" = "" ] && echo "ServerAliveInterval 15" >> "$HOME/.ssh/config"
AUTHKEY=$(grep "PubkeyAuthentication" "$HOME/.ssh/config")
[ "${AUTHKEY}" = "" ] && echo "PubkeyAuthentication yes" >> "$HOME/.ssh/config"
chmod 600 "$HOME/.ssh/config"

# if needed, generate keys
echo "generate SSH keys"
[ ! -f "$HOME/.ssh/id_rsa" ] && ssh-keygen -t rsa

# upload public key to SSH server
echo "upload public key to server"
ssh-copy-id -p "${SERVER_PORT}" "${SERVER_ACCOUNT}@${SERVER_ADDRESS}"

# test the connexion
echo "first connexion on ${SERVER_LABEL}"
ssh -v -p "${SERVER_PORT}" "${SERVER_ACCOUNT}@${SERVER_ADDRESS}"
