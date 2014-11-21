# ---------------------------------------------------
# Nautilus extension to add APK specific columns
# Procedure :
#   http://bernaerts.dyndns.org/linux/76-gnome/324-gnome-nautilus-apk-column-property-provider-extension
# Depends on :
#   * aapt
# Revision history :
#   08/11/2014, V1.0 - Creation by N. Bernaerts
# ---------------------------------------------------
import subprocess
import urllib
import os
import re
import pipes
from gi.repository import Nautilus, GObject

class ApkColumnExtension(GObject.GObject, Nautilus.ColumnProvider, Nautilus.InfoProvider):
  def __init__(self):
    pass
    
  def get_data(self,filename):
    apk_name = ""
    apk_versioncode = ""
    apk_versionname = ""
    apk_sdkversion = ""

    command_line = "aapt d badging " + pipes.quote(filename)
    p = subprocess.Popen(command_line , shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)

    for line in p.stdout.readlines():
      # new line, no match found
      found = False

      # line package:
      if found == False and apk_name == "":
        regexpr = re.match('^package:.*$', line)
        if regexpr: 
          apk_name = re.sub('^.*name=.([^ \']*).*$', '\g<1>', line).rstrip('\n')
          apk_versioncode = re.sub('^.*versionCode=.([^ \']*).*$', '\g<1>', line).rstrip('\n')
          apk_versionname = re.sub('^.*versionName=.([^ \']*).*$', '\g<1>', line).rstrip('\n')
          found = True

      # line sdkVersion:
      if found == False and apk_sdkversion == "":
        regexpr = re.match('^sdkVersion:.*$', line)
        if regexpr: 
          apk_sdkversion = re.sub('^sdkVersion:.([^ \']*).*$', '\g<1>', line).rstrip('\n')
          found = True

      if apk_name != "" and apk_sdkversion != "":
        break

    return apk_name, apk_versioncode, apk_versionname, apk_sdkversion

  def get_columns(self):
      return (
        Nautilus.Column(name="NautilusPython::ApkPkgName", attribute="apk_pkg_name", label="Package", description="Get Name of package"),
        Nautilus.Column(name="NautilusPython::ApkPkgVersion", attribute="apk_pkg_version", label="Version", description="Get Version Name of package"),
        Nautilus.Column(name="NautilusPython::ApkPkgCode", attribute="apk_pkg_code", label="Version\nCode", description="Get Version Code of package"),
        Nautilus.Column(name="NautilusPython::ApkSdkVersion", attribute="apk_sdk_version", label="SDK\nVersion", description="Get Sdk Version of package"),
      )

  def update_file_info(self, file):
    if file.get_uri_scheme() != 'file':
      return
        
    if file.get_mime_type() in ('application/vnd.android.package-archive'):
      filename = urllib.unquote(file.get_uri()[7:])
      result = self.get_data(filename)
    else:
      result=("", "", "", "") 

    file.add_string_attribute('apk_pkg_name', result[0])
    file.add_string_attribute('apk_pkg_code', result[1])
    file.add_string_attribute('apk_pkg_version', result[2])
    file.add_string_attribute('apk_sdk_version', result[3])
