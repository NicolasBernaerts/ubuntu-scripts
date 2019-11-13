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
ACCOUNT=$(grep "^account=" "${CONFIG_FILE}" | cut -d'=' -f2)

# check configuration data
[ "${NAME}" = "" ] && { echo "Ressource name not defined in ${CONFIG_FILE}"; exit 1; }
[ "${LABEL}" = "" ] && { echo "Ressource label not defined in ${CONFIG_FILE}"; exit 1; }
[ "${ACCOUNT}" = "" ] && { echo "Server account not defined in ${CONFIG_FILE}"; exit 1; }
[ "${ICON}" = "" ] && ICON="server"

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

# if needed, generate keys
echo "generate SSH keys"
[ ! -f "$HOME/.ssh/id_rsa" ] && ssh-keygen -t rsa

# loop to declare hosts in SSH config
echo "set SSH config"
SSH_CONFIG="$HOME/.ssh/config"
INDEX=1
while [ ${INDEX} -gt 0 ]
do
	# read configuration
	SERVER_ADDRESS=$(grep "^${INDEX}-address=" "${CONFIG_FILE}" | cut -d'=' -f2)
	SERVER_PORT=$(grep "^${INDEX}-port=" "${CONFIG_FILE}" | cut -d'=' -f2)
	[ "${SERVER_ADDRESS}" = "" ] && INDEX=0
	[ "${SERVER_PORT}" = "" ] && SERVER_PORT=22

	# if server configuration is read
	if [ ${INDEX} -gt 0 ]
	then
		# display progress
		echo " - server ${SERVER_ADDRESS}"

		# add host to file
		echo " " >> "${SSH_CONFIG}"
		echo "host ${NAME}_${INDEX}" >> "${SSH_CONFIG}"
		echo "HostName ${SERVER_ADDRESS}" >> "${SSH_CONFIG}"
		echo "Port ${SERVER_PORT}" >> "${SSH_CONFIG}"
		echo "User ${ACCOUNT}" >> "${SSH_CONFIG}"
		echo "ServerAliveInterval 15" >> "${SSH_CONFIG}"
		echo "PubkeyAuthentication yes" >> "${SSH_CONFIG}"
		echo "StrictHostKeyChecking no" >> "${SSH_CONFIG}"
		echo "Compression yes" >> "${SSH_CONFIG}"
		echo "CompressionLevel 9" >> "${SSH_CONFIG}"
		echo " " >> "${SSH_CONFIG}"

		# set access mode to 600
		chmod 600 "${SSH_CONFIG}"

		# if index is the one given as parameters
		if [ ${INDEX} -eq ${CONFIG_INDEX} ]
		then
			# upload public key to SSH server
			echo "   * upload public key to server"
			ssh-copy-id -p "${SERVER_PORT}" "${ACCOUNT}@${SERVER_ADDRESS}"

			# test the connexion
			echo "   * first connexion"
			ssh -p "${SERVER_PORT}" "${ACCOUNT}@${SERVER_ADDRESS}"
		fi

		# increment index
		INDEX=$((INDEX + 1))
	fi
done
