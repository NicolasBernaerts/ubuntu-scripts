# Nautilus APK information display 
# Adds a specific tab in Nautilus file properties
# for Android APK files
#
# Needs aapt to be installed
#
# History
#   02/03/2014, v1.0 - creation
#   24/04/2020, v2.0 - rewrite for python3 compatibility

import io
import subprocess
import os
import re
import pipes

from urllib.parse import unquote
from gi.repository import Nautilus, Gtk, GObject

class APKInfoPropertyPage(GObject.GObject, Nautilus.PropertyPageProvider):
  def __init__(self):
    pass
    
  # method to display one property
  def dislayLabel(self, title, value, x, y, height):

    # dislay title
    gtk_label = Gtk.Label()
    gtk_label.set_markup("<b>" + title + "</b>")
    gtk_label.set_alignment(1.0, 0)
    gtk_label.set_padding(10, 5)
    gtk_label.show()
    self.grid.attach(gtk_label, x, y, 1, height)

    # dislay value
    gtk_label = Gtk.Label(value)
    gtk_label.set_alignment(0.0, 0)
    gtk_label.set_padding(10, 5)
    gtk_label.show()
    self.grid.attach(gtk_label, x + 1, y, 1, height)
    
    return

  def get_property_pages(self, files):

    # test file parameter
    if len(files) != 1: return
    file = files[0]
    if file.get_uri_scheme() != 'file': return

    # if mimetype corresponds to APK file, read data and populate tab
    if file.get_mime_type() in ('application/vnd.android.package-archive'):
    
      # format filename
      filename = unquote(file.get_uri()[7:])

      # create label and grid
      self.property_label = Gtk.Label('APK')
      self.property_label.show()
      self.grid = Gtk.Grid()
      self.grid.show()

      # aapt command, using pipes to handle filenames including '(', ')', ...
      command_line = "aapt d badging " + pipes.quote(filename)
      proc = subprocess.Popen(command_line , shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)

      # multiline strings
      apk_features = ""
      apk_permissions = ""

      # initialise data flags  
      found_package = False
      found_application = False
      found_sdkversion = False
      found_targetsdk = False
      found_screens = False
      found_densities = False
      found_code = False

      # console return analysis
      for line in io.TextIOWrapper(proc.stdout, encoding="utf-8"):
        handled = False

        # line package:
        if handled == False and found_package == False:
          if re.compile('^package:.*$').match(line):
            handled = True
            found_package == True
            value = re.compile('^.*name=.([^ \']*).*$').sub('\g<1>', line).rstrip('\n')
            self.dislayLabel("Name", value, 0, 1, 1)
            value = re.compile('^.*versionCode=.([^ \']*).*$').sub('\g<1>',line).rstrip('\n')
            self.dislayLabel("Version code", value, 0, 2, 1)
            value = re.compile('^.*versionName=.([^ \']*).*$').sub('\g<1>', line).rstrip('\n')
            self.dislayLabel("Version name", value, 0, 3, 1)

        # line application:
        if handled == False and found_application == False:
          if re.compile('^application:.*$').match(line):
            handled = True
            found_application = True
            value = re.compile('^.*label=.([^ \']*).*$').sub('\g<1>', line).rstrip('\n')
            self.dislayLabel("Label", value, 0, 0, 1)


        # line sdkVersion:
        if handled == False and found_sdkversion == False:
          if re.compile('^sdkVersion:.*$').match(line):
            handled = True
            found_sdkversion = True
            value = re.compile('^sdkVersion:.([^ \']*).*$').sub('\g<1>', line).rstrip('\n')
            self.dislayLabel("SDK version", value, 0, 4, 1)

        # line targetSdkVersion:
        if handled == False and found_targetsdk == False:
          if re.compile('^targetSdkVersion:.*$').match(line):
            handled = True
            found_targetsdk = True
            value = re.compile('^targetSdkVersion:.([^ \']*).*$').sub('\g<1>', line).rstrip('\n')
            self.dislayLabel("Target SDK version", value, 0, 5, 1)

        # line native-code:
        if handled == False and found_code == False:
          if re.compile('^native-code:.*$').match(line): 
            handled = True
            found_code = True
            value = re.compile('^native-code:.(.*)$').sub('\g<1>', line)
            value = re.compile(' ').sub('\n', value)
            value = re.compile('\'').sub('', value).rstrip('\n')
            self.dislayLabel("Code", value, 0, 6, 1)

        # line supports-screens:
        if handled == False and found_screens == False:
          if re.compile('^supports-screens:.*$').match(line): 
            handled = True
            found_screens = True
            value = re.compile('^supports-screens:.(.*)$').sub('\g<1>', line)
            value = re.compile(' ').sub('\n', value)
            value = re.compile('\'').sub('', value).rstrip('\n')
            self.dislayLabel("Supported\nscreens", value, 0, 7, 1)

        # line densities:
        if handled == False and found_densities == False:
          if re.compile('^densities:.*$').match(line): 
            handled = True
            found_densities = True
            value = re.compile('^densities:.(.*)$').sub('\g<1>', line)
            value = re.compile(' ').sub('\n', value)
            value = re.compile('\'').sub('', value).rstrip('\n')
            self.dislayLabel("Supported\ndensities", value, 0, 8, 1)

        # line uses-feature:
        if handled == False:
          if re.compile('^  uses-feature:.*$').match(line):
            handled = True
            apk_features += re.compile('^  uses-feature: name=.(.*).$').sub('\g<1>', line)

        # line uses-permission:
        if handled == False:
          if re.compile('^uses-permission:.*$').match(line):
            handled = True
            apk_permissions += re.compile('^uses-permission: name=.(.*).$').sub('\g<1>', line)

      # dislay features and permissions
      self.dislayLabel("Used\nfeatures", apk_features.rstrip('\n'), 2, 0, 4)
      self.dislayLabel("Used\npermissions", apk_permissions.rstrip('\n'), 2, 4, 5)

      # return result
      return Nautilus.PropertyPage(name="NautilusPython::apk_info",
                                     label=self.property_label, 
                                     page=self.grid),
