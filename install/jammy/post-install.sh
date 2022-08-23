#!/usr/bin/env bash
# ---------------------------------------------------------------------------------
#  Ubuntu Jammy 22.04 LTS Post-installation script
#
#  This script will run some commands as sudo
# 
#  23/08/2022, V1.0 - Migrated from Focal
# ---------------------------------------------------------------------------------

# ---------------------------------------------------
# -------------- Parameters handling ----------------
# ---------------------------------------------------


DISTRI_NAME="jammy"
ARCHI="amd64"
X86ARCHI="64"

# help message if no parameter
if [ ${#} -eq 0 ];
then
    echo "Script to finalise Ubuntu ${DISTRI_NAME} installation."
    echo "It will install some important packages not provided by default installation."
    echo "Options are :"
    echo "  --common          Install common packages (gnomeshell, utilities, graphical, multimedia, internet and office"
    echo "  --design          Install design apps"
    echo "  --android         Install android tools"
    echo "  --programming     Install programming environment (Visual studio code, Tasmota, ...)"
    echo "  --tweaks          Add some tweaks for problematic hardware"
    echo "  --ssd             Apply SSD tweaks"
    echo "  --surface         Install Surface kernel and tools"
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
        --tweaks) TWEAKS="ok"; shift; ;;
        --ssd) SSD="ok"; shift; ;;
        --surface) SURFACE="ok"; shift; ;;
        --photorec) PHOTOREC="ok"; shift; ;;
        *) shift; ;;
    esac
done

# --------------------------------------------
# ------------- Initialisation ---------------
# --------------------------------------------

# Distribution detection
RESULT=$(cat /etc/lsb-release | grep "DISTRIB_CODENAME" | cut -d'=' -f2-)
[ "${RESULT}" != "${DISTRI_NAME}" ] && { echo "Distribution is ${RESULT}. This script is for ${DISTRI_NAME}"; exit 1; }

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
    wget --header='Accept-Encoding:none' https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/install/${DISTRI_NAME}/gnomeshell
    if [ -f ./gnomeshell ]
    then
        chmod +x ./gnomeshell
        ./gnomeshell
        rm ./gnomeshell
    fi

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
fi

# --------------------------------------------
# -----------------  Options  ----------------
# --------------------------------------------

# android tools
if [ "${ANDROID}" = "ok" ]
then
    wget https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/install/${DISTRI_NAME}/android
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

# Ms Surface : kernel and tools
if [ "${SURFACE}" = "ok" ]
then
    wget https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/install/${DISTRI_NAME}/surface
    if [ -f ./surface ]
    then
        chmod +x ./surface
        ./surface
        rm ./surface
    fi
fi

# SSD : tweaks
if [ "${SSD}" = "ok" ]
then
    wget https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/install/${DISTRI_NAME}/ssd
    if [ -f ./ssd ]
    then
        chmod +x ./ssd
        ./ssd
        rm ./ssd
    fi
fi

# programming
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
