#!/bin/bash
# --------------------------------------------
# Install extension from Gnome Shell Extensions site
#
# See http://bernaerts.dyndns.org/linux/76-gnome/345-gnome-shell-install-remove-extension-command-line-script
#  for installation instruction
#
# Revision history :
#   13/07/2013 - V1.0 : Creation by N. Bernaerts
#   15/03/2015 - V1.1 : Update thanks to Michele Gazzetti
#   02/10/2015 - V1.2 : Disable wget gzip compression
#   05/07/2016 - V2.0 : Complete rewrite (system path updated thanks to Morgan Read)
#   09/08/2016 - V2.1 : Handle exact or previously available version installation (idea from eddy-geek)
#   09/09/2016 - V2.2 : Switch to gnome-shell to get version [UbuntuGnome 16.04] (thanks to edgard)
#   05/11/2016 - V2.3 : Trim Gnome version and add Fedora compatibility (thanks to Cedric Brandenbourger)
#   19/01/2018 - V2.4 : Add option to force latest version (idea from Eduardo Minguez)
# -------------------------------------------

# check tools availability
command -v gnome-shell >/dev/null 2>&1 || { zenity --error --text="Please install gnome-shell"; exit 1; }
command -v unzip >/dev/null 2>&1 || { zenity --error --text="Please install unzip"; exit 1; }
command -v wget >/dev/null 2>&1 || { zenity --error --text="Please install wget"; exit 1; }

# install path (user and system mode)
USER_PATH="$HOME/.local/share/gnome-shell/extensions"
[ -f /etc/debian_version ] && SYSTEM_PATH="/usr/local/share/gnome-shell/extensions" || SYSTEM_PATH="/usr/share/gnome-shell/extensions"

# set gnome shell extension site URL
GNOME_SITE="https://extensions.gnome.org"

# get current gnome version (major and minor only)
TARGET_VERSION="$(DISPLAY=":0" gnome-shell --version | tr -cd "0-9." | cut -d'.' -f1,2)"
CURRENT_VERSION="${TARGET_VERSION}"

# default installation path for default mode (user mode, no need of sudo)
INSTALL_MODE="user"
EXTENSION_PATH="${USER_PATH}"
INSTALL_SUDO=""

# help message if no parameter
if [ ${#} -eq 0 ];
then
	echo "Install/remove extension from Gnome Shell Extensions site https://extensions.gnome.org/"
	echo "Extension ID should be retrieved from https://extensions.gnome.org/extension/<ID>/extension-name/"
	echo "Version installed will be targeted as the same as Gnome Shell or the next available one"
	echo "Parameters are :"
	echo "  --install               Install extension (default)"
	echo "  --remove                Remove extension"
	echo "  --user                  Installation/remove in user mode (default)"
	echo "  --system                Installation/remove in system mode"
	echo "  --version <version>     Force Gnome version (use 'latest' to force latest one)"
	echo "  --extension-id <id>     Extension ID in Gnome Shell Extension site (compulsory)"
	exit 1
fi

# iterate thru parameters
while test ${#} -gt 0
do
	case $1 in
		--install) ACTION="install"; shift; ;;
		--remove) ACTION="remove"; shift; ;;
		--user) INSTALL_MODE="user"; shift; ;;
		--system) INSTALL_MODE="system"; shift; ;;
		--version) shift; TARGET_VERSION="$1"; shift; ;;
		--extension-id) shift; EXTENSION_ID="$1"; shift; ;;
		*) echo "Unknown parameter $1"; shift; ;;
	esac
done

# if no extension id, exit
[ "${EXTENSION_ID}" = "" ] && { echo "You must specify an extension ID"; exit; }

# if no action, exit
[ "${ACTION}" = "" ] && { echo "You must specify an action command (--install or --remove)"; exit; }

# if system mode, set system installation path and sudo mode
[ "${INSTALL_MODE}" = "system" ] && { EXTENSION_PATH="${SYSTEM_PATH}"; INSTALL_SUDO="sudo"; }

# create temporary files
TMP_DESC=$(mktemp -t ext-XXXXXXXX.txt) && rm ${TMP_DESC}
TMP_ZIP=$(mktemp -t ext-XXXXXXXX.zip) && rm ${TMP_ZIP}
TMP_VERSION=$(mktemp -t ext-XXXXXXXX.ver) && rm ${TMP_VERSION}

# get extension description
wget --quiet --header='Accept-Encoding:none' -O "${TMP_DESC}" "${GNOME_SITE}/extension-info/?pk=${EXTENSION_ID}"

# get extension name
EXTENSION_NAME=$(sed 's/^.*name[\": ]*\([^\"]*\).*$/\1/' "${TMP_DESC}")

# get extension description
EXTENSION_DESCR=$(sed 's/^.*description[\": ]*\([^\"]*\).*$/\1/' "${TMP_DESC}")

# get extension UUID
EXTENSION_UUID=$(sed 's/^.*uuid[\": ]*\([^\"]*\).*$/\1/' "${TMP_DESC}")

# if ID not known
if [ ! -s "${TMP_DESC}" ]
then
	# error message
	echo "[Error] Extension with ID ${EXTENSION_ID} is not available from Gnome Shell Extension site."

# else, if installation mode
elif [ "${ACTION}" = "install" ];
then

	# extract all available versions
	sed "s/\([0-9]*\.[0-9]*[0-9\.]*\)/\n\1/g" "${TMP_DESC}" | grep "pk" | grep "version" | sed "s/^\([0-9\.]*\).*$/\1/" | sort -V > "${TMP_VERSION}"

	# lok for latest version or for current one
	[ "${TARGET_VERSION}" = "latest" ] && VERSION_AVAILABLE=$(cat "${TMP_VERSION}" | tail -n 1) || VERSION_AVAILABLE=$(grep "^${TARGET_VERSION}$" "${TMP_VERSION}")

	# if no candidate version found, get the next one after current version
	if [ "${VERSION_AVAILABLE}" = "" ]
	then
		# create a version list including current version
		cp "${TMP_VERSION}" "${TMP_DESC}" 
		echo "${TARGET_VERSION}" >> "${TMP_DESC}"

		# sort by version and get next version available after current version
		VERSION_AVAILABLE=$(cat "${TMP_DESC}" | sort -V | sed "1,/${TARGET_VERSION}/d" | head -n 1)
	fi

	# if candidate version has been found, installation
	if [ "${VERSION_AVAILABLE}" != "" ]
	then

		# get extension description
		wget --quiet --header='Accept-Encoding:none' -O "${TMP_DESC}" "${GNOME_SITE}/extension-info/?pk=${EXTENSION_ID}&shell_version=${VERSION_AVAILABLE}"

		# get extension download URL
		EXTENSION_URL=$(sed 's/^.*download_url[\": ]*\([^\"]*\).*$/\1/' "${TMP_DESC}")

		# download extension archive
		wget --quiet --header='Accept-Encoding:none' -O "${TMP_ZIP}" "${GNOME_SITE}${EXTENSION_URL}"

		# unzip extension to installation folder
		${INSTALL_SUDO} mkdir -p ${EXTENSION_PATH}/${EXTENSION_UUID}
		${INSTALL_SUDO} unzip -oq "${TMP_ZIP}" -d ${EXTENSION_PATH}/${EXTENSION_UUID}
		${INSTALL_SUDO} chmod +r ${EXTENSION_PATH}/${EXTENSION_UUID}/*

		# list enabled extensions (remove @as in case of no extension enabled)
		EXTENSION_LIST=$(gsettings get org.gnome.shell enabled-extensions | sed 's/^@as //' | tr -d '[]')
		[ "${EXTENSION_LIST}" != "" ] && EXTENSION_LIST="${EXTENSION_LIST},"

		# if extension not already enabled, declare it
		EXTENSION_ENABLED=$(echo ${EXTENSION_LIST} | grep ${EXTENSION_UUID})
		[ "$EXTENSION_ENABLED" = "" ] && gsettings set org.gnome.shell enabled-extensions "[${EXTENSION_LIST}'${EXTENSION_UUID}']"

		# success message
		echo "[success] Extension ${EXTENSION_NAME} version ${VERSION_AVAILABLE} has been installed in ${INSTALL_MODE} mode (Id ${EXTENSION_ID}, Uuid ${EXTENSION_UUID})"
		echo "Restart Gnome Shell ${CURRENT_VERSION} to take effect."

	# else, error
	else
		# generate list of available versions
		LST_VERSION=$(cat ${TMP_VERSION} | sort -V | xargs)
		
		# display error message
		echo "[Error] Gnome Shell version is ${CURRENT_VERSION}, no candidate extension ${EXTENSION_NAME} found"
		echo "Available versions are ${LST_VERSION}"
	fi

# else, if it is remove mode
elif [ "${ACTION}" = "remove" ]
then

	# if extension is installed, removal
	if [ -d "${EXTENSION_PATH}/${EXTENSION_UUID}" ]
	then
		# remove extension folder
		${INSTALL_SUDO} rm -f -r "${EXTENSION_PATH}/${EXTENSION_UUID}"

		# success message
		echo "[Success] Extension ${EXTENSION_NAME} has been removed in ${INSTALL_MODE} mode (Id ${EXTENSION_ID}, Uuid ${EXTENSION_UUID})"
		echo "Restart Gnome Shell ${CURRENT_VERSION} to take effect."

	# else, extension not found, error
	else
		# error message
		echo "[Error] Extension ${EXTENSION_NAME} has not been found in ${INSTALL_MODE} mode (Id ${EXTENSION_ID}, Uuid ${EXTENSION_UUID})"
	fi

fi

# remove temporary files
rm -f ${TMP_DESC} ${TMP_ZIP} ${TMP_VERSION}
