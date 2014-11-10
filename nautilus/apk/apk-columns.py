# ---------------------------------------------------
# Nautilus extension to add APK specific columns
# Depends on :
# * aapt
# Revision history :
# 08/11/2014, V1.0 - Creation by N. Bernaerts
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
   
  # method to extract data from aapt console  
  def get_data(self,filename):
    apk_name = ""
    apk_versioncode = ""
    apk_versionname = ""
    apk_label = ""
    apk_sdkversion = ""
    apk_targetsdkversion = ""

    # aapt command, using pipes to handle filenames including '(', ')', ...
    command_line = "aapt d badging " + pipes.quote(filename)
    p = subprocess.Popen(command_line , shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)

    # console return analysis
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

      # line application:
      if found == False and apk_label == "":
        regexpr = re.match('^application:.*$', line)
        if regexpr: 
          apk_label = re.sub('^.*label=.([^ \']*).*$', '\g<1>', line).rstrip('\n')
          found = True
    
      # line sdkVersion:
      if found == False and apk_sdkversion == "":
        regexpr = re.match('^sdkVersion:.*$', line)
        if regexpr: 
          apk_sdkversion = re.sub('^sdkVersion:.([^ \']*).*$', '\g<1>', line).rstrip('\n')
          found = True

      # line targetSdkVersion:
      if found == False and apk_targetsdkversion == "":
        regexpr = re.match('^targetSdkVersion:.*$', line)
        if regexpr: 
          apk_targetsdkversion = re.sub('^targetSdkVersion:.([^ \']*).*$', '\g<1>', line).rstrip('\n')
          found = True

      if apk_name != "" and apk_label != "" and apk_sdkversion != "" and apk_targetsdkversion != "":
        break

    # return data array
    return apk_name, apk_versioncode, apk_versionname, apk_label, apk_sdkversion, apk_targetsdkversion  

  # method to get new columns description
  def get_columns(self):
      return (
        Nautilus.Column(name="NautilusPython::ApkPkgName", attribute="apk_pkg_name", label="APK\nName", description="Get Name of package"),
        Nautilus.Column(name="NautilusPython::ApkPkgCode", attribute="apk_pkg_code", label="Version\nCode", description="Get Version Code of package"),
        Nautilus.Column(name="NautilusPython::ApkPkgVersion", attribute="apk_pkg_version", label="Version\nName", description="Get Version Name of package"),
        Nautilus.Column(name="NautilusPython::ApkAppLabel", attribute="apk_app_label", label="APK\nLabel", description="Get Label of package"),
        Nautilus.Column(name="NautilusPython::ApkSdkVersion", attribute="apk_sdk_version", label="Sdk\nVersion", description="Get Sdk Version of package"),
        Nautilus.Column(name="NautilusPython::ApkTgtVersion", attribute="apk_tgt_version", label="Target Sdk\nVersion", description="Get Target Sdk Version of package"),
      )

  # method to read new column values from file
  def update_file_info(self, file):

    # if not dealing with file, return
    if file.get_uri_scheme() != 'file':
      return

    # if mimetype corresponds to APK file, read data
    result=("", "", "", "", "", "", "")
    if file.get_mime_type() in ('application/vnd.android.package-archive'):
      filename = urllib.unquote(file.get_uri()[7:])
      result = self.get_data(filename)

    # add new data to file attributes
    file.add_string_attribute('apk_pkg_name', result[0])
    file.add_string_attribute('apk_pkg_code', result[1])
    file.add_string_attribute('apk_pkg_version', result[2])
    file.add_string_attribute('apk_app_label', result[3])
    file.add_string_attribute('apk_sdk_version', result[4])
    file.add_string_attribute('apk_tgt_version', result[5])
