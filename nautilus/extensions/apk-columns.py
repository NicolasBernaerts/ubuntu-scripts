#!/usr/bin/env python3
# ---------------------------------------------------
#
# Nautilus extension to add APK specific columns
#
# Dependency :
#   * aapt
#
# Procedure :
#   http://www.bernaerts-nicolas.fr/linux/76-gnome/324-gnome-nautilus-apk-column-property-provider-extension
#
# Revision history :
#   08/11/2014, V1.0 - Creation by N. Bernaerts
#   25/04/2020, v2.0 - rewrite for python3 compatibility
#                      add application name
#   30/04/2025, v2.1 - change \g to \\g
#
# ---------------------------------------------------

# -------------------
#  Import libraries
# -------------------

import io
import subprocess
import re
import pipes
from urllib.parse import unquote
from gi.repository import Nautilus, GObject

# --------------------
#   Class definition
# --------------------

class ApkColumnExtension(GObject.GObject, Nautilus.ColumnProvider, Nautilus.InfoProvider):
  def __init__(self): pass
    
  # -----------------------------
  #   List of available columns
  # -----------------------------
  def get_columns(self):
    return (
      Nautilus.Column(name="NautilusPython::Apk1", attribute="apk_pkg_app", label="APK\nApp", description="Application name"),
      Nautilus.Column(name="NautilusPython::Apk2", attribute="apk_pkg_ver", label="APK\nApp ver.", description="Application version"),
      Nautilus.Column(name="NautilusPython::Apk3", attribute="apk_pkg_name", label="APK\nPkg", description="Package name"),
      Nautilus.Column(name="NautilusPython::Apk4", attribute="apk_pkg_code", label="APK\nPkg ver.", description="Package version"),
      Nautilus.Column(name="NautilusPython::Apk5", attribute="apk_sdk_ver", label="APK\nSDK ver.", description="SDK version"),
    )

  # ------------------------
  #   Retrieve file values
  # ------------------------
  def update_file_info(self, file):
 
    # test file type
    if file.get_uri_scheme() != 'file': return
        
    # if mimetype corresponds to APK file, read data and populate tab
    if file.get_mime_type() in ('application/vnd.android.package-archive'):

      # format filename
      filename = unquote(file.get_uri()[7:])

      # aapt command, using pipes to handle filenames including '(', ')', ...
      command_line = "aapt d badging " + pipes.quote(filename)
      proc = subprocess.Popen(command_line , shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)

      # initialise data flags  
      found_package = False
      found_application = False
      found_sdkversion = False

      # console return analysis
      for line in io.TextIOWrapper(proc.stdout, encoding="utf-8"):
        handled = False

        # line package:
        if handled == False and found_package == False:
          if re.compile('^package:.*$').match(line):
            handled = True
            found_package == True
            value = re.compile('^.*name=.([^ \']*).*$').sub('\\g<1>', line).rstrip('\n')
            file.add_string_attribute('apk_pkg_name', value)
            value = re.compile('^.*versionName=.([^ \']*).*$').sub('\\g<1>', line).rstrip('\n')
            file.add_string_attribute('apk_pkg_ver', value)
            value = re.compile('^.*versionCode=.([^ \']*).*$').sub('\\g<1>',line).rstrip('\n')
            file.add_string_attribute('apk_pkg_code', value)
           
        # line application:
        if handled == False and found_application == False:
          if re.compile('^application:.*$').match(line):
            handled = True
            found_application = True
            value = re.compile('^.*label=.([^ \']*).*$').sub('\\g<1>', line).rstrip('\n')
            file.add_string_attribute('apk_pkg_app', value)
           
        # line sdkVersion:
        if handled == False and found_sdkversion == False:
          if re.compile('^sdkVersion:.*$').match(line):
            handled = True
            found_sdkversion = True
            value = re.compile('^sdkVersion:.([^ \']*).*$').sub('\\g<1>', line).rstrip('\n')
            file.add_string_attribute('apk_sdk_ver', value)

    # else, file is not an APK
    else:
      file.add_string_attribute('apk_pkg_name', "")
      file.add_string_attribute('apk_pkg_code', "")
      file.add_string_attribute('apk_pkg_ver', "")
      file.add_string_attribute('apk_pkg_app', "")
      file.add_string_attribute('apk_sdk_ver', "")

