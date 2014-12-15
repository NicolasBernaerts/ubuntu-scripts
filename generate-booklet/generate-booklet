#!/bin/bash
# Imposition of a PDF document to generate a booklet
# target format is selectable (A5, A4, ...)
# default format is A4
#
# Depends on packages
#  * pdfjam
#  * poppler-utils
#
# Parameter :
#   $1 - full path of original document
#
# Version history :
#   26/09/2012, V1.0 - Creation by N. Bernaerts
#   05/05/2014, V2.0 - Add target format selection (thanks to Robin idea)

# suffix to be added at the end of booklet file
DOC_SUFFIX="book"

# determine file names
DOC_ORIGINAL="$1"
DOC_BOOKLET="`echo "$1" | sed 's/\(.*\)\..*/\1/'`-$DOC_SUFFIX.pdf"

# select target format
ARR_FORMAT=('false' 'A2' 'false' 'A3' 'true' 'A4' 'false' 'A5' 'false' 'Letter' 'false' 'Executive' 'false' 'Legal')
TITLE=`basename "$1"`
TEXT="Booklet will be generated from this document.\nPlease select target format.\n"
FORMAT=`zenity --list --radiolist --width 350 --height 380 --title "$TITLE" --text "$TEXT" --column="Choice" --column="Format" ${ARR_FORMAT[@]}`

# if a format has been selected
if [ "$FORMAT" != "" ]
  then
  # set target format as expected by pdfbook
  FORMAT_OPTION="--${FORMAT,,}paper"

  # determine number of pages of original PDF
  NUM_PAGES=`pdfinfo "$DOC_ORIGINAL" | grep Pages | sed 's/^Pages:[ ]*\([0-9]*\).*$/\1/g'`

  # determine if there is a need to add blank pages at the end
  DIV_RESULT=`expr $NUM_PAGES % 4`
  if [ $DIV_RESULT -gt 0 ]
    then
    # add pages to get multiple of 4
    NUM_PAGES=`expr $NUM_PAGES + 4 - $DIV_RESULT`
  fi

  # generate document with proper page number (multiple of 4)
  pdfbook $FORMAT_OPTION --signature $NUM_PAGES --booklet true --landscape "$DOC_ORIGINAL" -o "$DOC_BOOKLET"
fi
