#!/bin/bash
# ---------------------------------------------------
# Repair broken PDF file using gs
#
# Depends on :
#   * ghostscript
#   * mupdf-tools
#   * gridsite-clients
#
# Parameter :
#   $1 - URI of original PDF
#
# Revision history :
#   08/11/2014, V1.0 - Creation by N. Bernaerts
#   20/11/2014, V1.1 - Add file selection dialog box
#   24/01/2015, V1.2 - Check tools availability
#   24/11/2017, V2.0 - Add MuTool repair method (thank to Willie Wildgrube idea)
# ---------------------------------------------------

# check tools availability
command -v gvfs-copy >/dev/null 2>&1 || { zenity --error --text="Please install gvfs-copy [gvfs-bin]"; exit 1; }
command -v notify-send >/dev/null 2>&1 || { zenity --error --text="Please install notify-send [libnotify-bin]"; exit 1; }
command -v gs >/dev/null 2>&1 || { zenity --error --text="Please install gs [ghostscript]"; exit 1; }
command -v mutool >/dev/null 2>&1 || { zenity --error --text="Please install mutool [mupdf-tools]"; exit 1; }
command -v urlencode >/dev/null 2>&1 || { zenity --error --text="Please install urlencode [gridsite-clients]"; exit 1; }

# check if parameter is given, otherwise open dialog box selection
[ "$1" != "" ] && DOC_URI="$1" || DOC_URI=$(zenity --file-selection --title="Select PDF file to repair")

# if no file selected, exit
[ "$DOC_URI" = "" ] && exit 1

# extract document name and extension
DOC_BASE=$(echo "${DOC_URI}" | sed 's/^\(.*\)\.[a-zA-Z0-9]*$/\1/')
DOC_EXT=$(echo "${DOC_URI}" | sed 's/^.*\.\([a-zA-Z0-9]*\)$/\1/')

# set PDF extension for files without extension
[ "${DOC_BASE}" = "${DOC_EXT}" ] && DOC_EXT="pdf"

# generate temporary local filename
TMP_ORIGINAL=$(mktemp -t XXXXXXXX.pdf) && rm "${TMP_ORIGINAL}"
TMP_REPAIRED=$(mktemp -t XXXXXXXX.pdf) && rm "${TMP_REPAIRED}"

# copy input file to temporary local file
gvfs-copy "${DOC_URI}" "${TMP_ORIGINAL}"

# -----------------------
# Repair with GhostScript
# -----------------------

# generate repaired PDF
gs -q -dNOPAUSE -dBATCH -dSAFER -sDEVICE=pdfwrite -sOutputFile="${TMP_REPAIRED}" "${TMP_ORIGINAL}"

# place corrected file side to original 
gvfs-copy "${TMP_REPAIRED}" "${DOC_BASE} (GhostScript repaired).${DOC_EXT}"

# remove temporary file
rm -f "${TMP_REPAIRED}" 

# ------------------
# Repair with MuTool
# ------------------

# generate repaired PDF
mutool clean "${TMP_ORIGINAL}" "${TMP_REPAIRED}"

# place corrected file side to original 
gvfs-copy "${TMP_REPAIRED}" "${DOC_BASE} (MuPDF repaired).${DOC_EXT}"

# ------------
# Notification
# ------------

# get document name and convert URI format
DOC_NAME=$(basename "${DOC_URI}")
DOC_DISPLAY=$(urlencode -d "${DOC_NAME}")

# send desktop notification
notify-send -i pdf-repair "${DOC_DISPLAY} repaired"

# remove temporary files
rm -f "${TMP_ORIGINAL}" "${TMP_REPAIRED}"
