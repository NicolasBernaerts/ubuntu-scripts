#!/usr/bin/env bash
# ---------------------------------------------------------------------------------
#  Ubuntu Focal 20.04 LTS Post-installation script
#
#  This script will run some commands as sudo
# 
#  01/05/2020, V1.0 - Migrated from Bionic
# ---------------------------------------------------------------------------------

# ---------------------------------------------------
# ------------- User defined variable ---------------
# ---------------------------------------------------

DISTRI_NAME="focal"
ARCHI="amd64"
X86ARCHI="64"

# ---------------------------------------------------
# ------------ Distribution detection ---------------
# ---------------------------------------------------

RESULT=$(cat /etc/lsb-release | grep "DISTRIB_CODENAME" | cut -d'=' -f2-)
[ "${RESULT}" != "${DISTRI_NAME}" ] && { echo "Distribution is ${RESULT}. This script is for ${DISTRI_NAME}"; exit 1; }

# ---------------------------------------------------
# -------------- Parameters handling ----------------
# ---------------------------------------------------

# help message if no parameter
if [ ${#} -eq 0 ];
then
    echo "Script to finalise Ubuntu ${DISTRI_NAME} installation."
    echo "It will install some important packages not provided by default installation."
    echo "Options are :"
    echo "  --start           Start install"
    echo "  --design          Install design apps"
    echo "  --photorec        Add photorec tools"
    echo "  --docky           Add docky launcher"
    echo "  --programming     Install programming environment (Visual studio code, Tasmota, ...)"
    echo "  --tweaks          Add some tweaks for problematic hardware"
    exit 1
fi

# iterate thru parameters
while test ${#} -gt 0
do
    case $1 in
        --start) START="ok"; shift; ;;
        --design) DESIGN="ok"; shift; ;;
        --photorec) PHOTOREC="ok"; shift; ;;
        --docky) DOCKY="ok"; shift; ;;
        --programming) PROGRAMMING="ok"; shift; ;;
        --tweaks) TWEAKS="ok"; shift; ;;
        *) shift; ;;
    esac
done

# if start not selected, exit
[ "${START}" != "ok" ] && exit 1

# ---------------------------------------------------
# -------------- Disable sudo timeout ---------------
# ---------------------------------------------------

sudo sh -c 'echo "\nDefaults timestamp_timeout=-1" >> /etc/sudoers'

# ---------------------------------------------------
# --------------- Full System Update ----------------
# ---------------------------------------------------

sudo apt update
sudo apt -y upgrade

# ---------------------------------------------------
# ------------------  Gnome Shell  ------------------
# ---------------------------------------------------

# gnomeshell
wget --header='Accept-Encoding:none' https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/install/${DISTRI_NAME}/gnomeshell
if [ -f ./gnomeshell ]
then
    chmod +x ./gnomeshell
    ./gnomeshell
    rm ./gnomeshell
fi

# ---------------------------------------------------
# ----------------- Common Packages  ----------------
# ---------------------------------------------------

# utilities and tools
wget https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/install/${DISTRI_NAME}/utilities
if [ -f ./utilities ]
then
    chmod +x ./utilities
    ./utilities
    rm ./utilities
fi

# office tools
wget https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/install/${DISTRI_NAME}/office
if [ -f ./office ]
then
    chmod +x ./office
    ./office
    rm ./office
fi

# graphical tools
wget https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/install/${DISTRI_NAME}/graphical
if [ -f ./graphical ]
then
    chmod +x ./graphical
    ./graphical
    rm ./graphical
fi

# multimedia tools
wget https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/install/${DISTRI_NAME}/multimedia
if [ -f ./multimedia ]
then
    chmod +x ./multimedia
    ./multimedia
    rm ./multimedia
fi

# internet tools
wget https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/install/${DISTRI_NAME}/internet
if [ -f ./internet ]
then
    chmod +x ./internet
    ./internet
    rm ./internet
fi

# android tools
wget https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/install/${DISTRI_NAME}/android
if [ -f ./android ]
then
    chmod +x ./android
    ./android
    rm ./android
fi

# ---------------------------------------------------
# -----------------  Common options  ----------------
# ---------------------------------------------------

# design apps
if [ "${DESIGN}" = "ok" ]
then
    wget https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/install/${DISTRI_NAME}/design
    if [ -f ./design ]
    then
        chmod +x ./design
        ./design
        rm ./design
    fi
fi

# tweaks
if [ "${TWEAKS}" = "ok" ]
then
    wget https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/install/${DISTRI_NAME}/tweaks
    if [ -f ./tweaks ]
    then
        chmod +x ./tweaks
        ./tweaks
        rm ./tweaks
    fi
fi

# Photorec
if [ "${PHOTOREC}" = "ok" ]
then
    wget https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/tools/qphotorec-install.sh
    if [ -f ./qphotorec-install.sh ]
    then
        logger "Tools - Photorec"
        chmod +x ./qphotorec-install.sh
        ./qphotorec-install.sh
        rm ./qphotorec-install.sh
    fi
fi

# docky : add desktop launcher
if [ "${DOCKY}" = "ok" ]
then
    wget https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/tools/docky-install.sh
    if [ -f ./docky-install.sh ]
    then
        chmod +x ./docky-install.sh
        ./docky-install.sh
        rm ./docky-install.sh
    fi
fi

# arduino
if [ "${PROGRAMMING}" = "ok" ]
then
    wget https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/install/${DISTRI_NAME}/programming
    if [ -f ./programming ]
    then
        chmod +x ./programming
        ./programming
        rm ./programming
    fi
fi

# ---------------------------------------------------
# ------------------ Package cleanup ----------------
# ---------------------------------------------------

# packages
sudo apt -y autoremove
sudo apt -y autoclean

# purge thumbnails cache
[ -d $HOME/.thumbnails ] && rm -r $HOME/.thumbnails/*
[ -d $HOME/.cache/thumbnails ] && rm -r $HOME/.cache/thumbnails/*

# ---------------------------------------------------
# -------------- Enable sudo timeout ---------------
# ---------------------------------------------------

sudo sed -i "/Defaults timestamp_timeout=-1/d" /etc/sudoers
