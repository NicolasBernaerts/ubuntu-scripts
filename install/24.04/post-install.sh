#!/usr/bin/env bash
# ---------------------------------------------------------------------------------
#  Ubuntu Jammy 24.04 LTS Post-installation script
#
#  This script will run some commands as sudo
# 
#  06/12/2024, V1.0 - Migrated from 22.04
# ---------------------------------------------------------------------------------

# ---------------------------------------------------
# -------------- Parameters handling ----------------
# ---------------------------------------------------


DISTRI_VERSION="24.04"
ARCHI="amd64"
X86ARCHI="64"

# help message if no parameter
if [ ${#} -eq 0 ];
then
    echo "Script to finalise Ubuntu ${DISTRI_VERSION} installation."
    echo "It will install some important packages not provided by default installation."
    echo "Options are :"
    echo "  --common          Install common packages (gnomeshell, utilities, graphical, multimedia, internet and office"
    echo "  --design          Install design apps"
    echo "  --android         Install android tools"
    echo "  --programming     Install programming environment (Visual studio code, Tasmota, ...)"
    echo "  --photorec        Add photorec tools"
    exit 1
fi

# iterate thru parameters
while test ${#} -gt 0
do
    case $1 in
        --common) COMMON="ok"; shift; ;;
        --design) DESIGN="ok"; shift; ;;
        --android) ANDROID="ok"; shift; ;;
        --programming) PROGRAMMING="ok"; shift; ;;
        --photorec) PHOTOREC="ok"; shift; ;;
        *) shift; ;;
    esac
done

# --------------------------------------------
# ------------- Initialisation ---------------
# --------------------------------------------

# Distribution detection
RESULT=$(cat /etc/lsb-release | grep "DISTRIB_RELEASE" | cut -d'=' -f2-)
[ "${RESULT}" != "${DISTRI_VERSION}" ] && { echo "Distribution is ${RESULT}. This script is for ${DISTRI_VERSION}"; exit 1; }

# Disable sudo timeout
sudo sh -c 'echo "\nDefaults timestamp_timeout=-1" >> /etc/sudoers'

# Full System Update
sudo apt update
sudo apt -y upgrade

# ---------------------------------------------------
# ----------------- Common Packages  ----------------
# ---------------------------------------------------

if [ "${COMMON}" = "ok" ]
then
    # gnomeshell
    wget --header='Accept-Encoding:none' https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/install/${DISTRI_VERSION}/gnomeshell
    if [ -f ./gnomeshell ]
    then
        chmod +x ./gnomeshell
        ./gnomeshell
        rm ./gnomeshell
    fi

    # utilities and tools
    wget https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/install/${DISTRI_VERSION}/utilities
    if [ -f ./utilities ]
    then
        chmod +x ./utilities
        ./utilities
        rm ./utilities
    fi

    # office tools
    wget https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/install/${DISTRI_VERSION}/office
    if [ -f ./office ]
    then
        chmod +x ./office
        ./office
        rm ./office
    fi

    # graphical tools
    wget https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/install/${DISTRI_VERSION}/graphical
    if [ -f ./graphical ]
    then
        chmod +x ./graphical
        ./graphical
        rm ./graphical
    fi

    # multimedia tools
    wget https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/install/${DISTRI_VERSION}/multimedia
    if [ -f ./multimedia ]
    then
        chmod +x ./multimedia
        ./multimedia
        rm ./multimedia
    fi

    # internet tools
    wget https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/install/${DISTRI_VERSION}/internet
    if [ -f ./internet ]
    then
        chmod +x ./internet
        ./internet
        rm ./internet
    fi
fi

# --------------------------------------------
# -----------------  Options  ----------------
# --------------------------------------------

# android tools
if [ "${ANDROID}" = "ok" ]
then
    wget https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/install/${DISTRI_VERSION}/android
    if [ -f ./android ]
    then
        chmod +x ./android
        ./android
        rm ./android
    fi
fi

# design apps
if [ "${DESIGN}" = "ok" ]
then
    wget https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/install/${DISTRI_VERSION}/design
    if [ -f ./design ]
    then
        chmod +x ./design
        ./design
        rm ./design
    fi
fi

# programming
if [ "${PROGRAMMING}" = "ok" ]
then
    wget https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/install/${DISTRI_VERSION}/programming
    if [ -f ./programming ]
    then
        chmod +x ./programming
        ./programming
        rm ./programming
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

# ---------------------------------------------------
# ------------------ Package cleanup ----------------
# ---------------------------------------------------

# packages
sudo apt -y autoremove
sudo apt -y autoclean

# purge thumbnails cache
[ -d $HOME/.thumbnails ] && rm -r $HOME/.thumbnails/*
[ -d $HOME/.cache/thumbnails ] && rm -r $HOME/.cache/thumbnails/*

# Enable sudo timeout
sudo sed -i "/Defaults timestamp_timeout=-1/d" /etc/sudoers
