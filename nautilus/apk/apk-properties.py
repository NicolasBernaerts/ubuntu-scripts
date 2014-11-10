# ---------------------------------------------------
# Nautilus extension to add APK properties tab
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
from gi.repository import Nautilus, GObject, Gtk

class ApkPropertyPage(GObject.GObject, Nautilus.PropertyPageProvider):
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
    apk_supportsscreens = ""
    apk_densities = ""
    apk_features = ""
    apk_permissions = ""

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

      # line supports-screens:
      if found == False and apk_supportsscreens == "":
        regexpr = re.match('^supports-screens:.*$', line)
        if regexpr: 
          text = re.sub('^supports-screens:.(.*)$', '\g<1>', line)
          text = re.sub(' ', ' & ', text)
          apk_supportsscreens = re.sub('\'', '', text).rstrip('\n')
          found = True

      # line densities:
      if found == False and apk_densities == "":
        regexpr = re.match('^densities:.*$', line)
        if regexpr: 
          text = re.sub('^densities:.(.*)$', '\g<1>', line)
          text = re.sub(' ', ' & ', text)
          apk_densities = re.sub('\'', '', text).rstrip('\n')
          found = True

      # line uses-feature:
      if found == False:
        regexpr = re.match('^uses-feature:.*$', line)
        if regexpr: 
          apk_features += re.sub('^uses-feature:.(.*).$', '\g<1>', line)
          found = True

      # line uses-permission:
      if found == False:
        regexpr = re.match('^uses-permission:.*$', line)
        if regexpr: 
          apk_permissions += re.sub('^uses-permission:.(.*).$', '\g<1>', line)
          found = True

    # remove last CR/LF
    apk_features = apk_features.rstrip('\n')
    apk_permissions = apk_permissions.rstrip('\n')

    # return data array
    return apk_name, apk_versioncode, apk_versionname, apk_label, apk_sdkversion, apk_targetsdkversion, apk_supportsscreens, apk_densities, apk_features, apk_permissions

  # method to add one property to properties table
  def populateTable(self, definition, value):

    # add definition to table
    label_def = Gtk.Label()
    label_def.set_markup("<b>" + definition + ":</b>")
    label_def.set_alignment(1.0, 0)
    label_def.set_padding(10, 0)
    self.table.attach(label_def, 0, 1, self.table_index, self.table_index + 1)

    # add value to table
    label_val = Gtk.Label(value)
    label_val.set_alignment(0.0, 0)
    label_val.set_padding(10, 0)
    self.table.attach(label_val, 1, 2, self.table_index, self.table_index + 1)
    
    # shift to next row
    self.table_index += 1
    return

  # method to generate APK properties tab
  def get_property_pages(self, files):
  
    # if dealing with multiple selection, return
    if len(files) != 1:
      return

    # if not dealing with file, return
    file = files[0]
    if file.get_uri_scheme() != 'file':
      return

    # if mimetype corresponds to APK file, read data and populate tab
    if file.get_mime_type() in ('application/vnd.android.package-archive'):
    
      # read data from APK file
      filename = urllib.unquote(file.get_uri()[7:])
      result = self.get_data(filename)

      # create table
      self.table = Gtk.Table(10, 2, False)
      self.table.set_row_spacings(5)

      # populate table
      self.table_index=0
      self.populateTable("Name", result[0])
      self.populateTable("Version name", result[2])
      self.populateTable("Version code", result[1])
      self.populateTable("Label", result[3])
      self.populateTable("SDK version", result[4])
      self.populateTable("Target SDK version", result[5])
      self.populateTable("Supported screens", result[6])
      self.populateTable("Supported densities", result[7])
      self.populateTable("Features used", result[8])
      self.populateTable("Permissions used", result[9])

      # set tab label
      apk_label = Gtk.Label('APK infos')

      # set tab content (vbox -> scrolled window -> table)
      apk_page = Gtk.VBox(False, 10)
      apk_win = Gtk.ScrolledWindow()
      apk_win.add_with_viewport(self.table)
      apk_page.pack_start(apk_win, True, True, 10)
      apk_page.show_all()

    # return label and tab content
    return Nautilus.PropertyPage( name="NautilusPython::apk_info", label=apk_label, page=apk_page ),
    
