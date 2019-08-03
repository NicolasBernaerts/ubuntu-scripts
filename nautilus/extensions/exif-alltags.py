#!/usr/bin/python3
# ---------------------------------------------------------
# Nautilus extension to display EXIF properties tab
# Procedure :
#   http://bernaerts.dyndns.org/linux/...
#
# Revision history :
#   02/09/2016, V1.0 - Creation by N. Bernaerts
# ---------------------------------------------------

# import libraries
import urllib
import os
import os.path
import re
import pygtk
import gi
gi.require_version("GExiv2", "0.10")
from gi.repository import GExiv2
gi.require_version("Nautilus", "3.0")
from gi.repository import Nautilus, GObject, Gtk

# -------------------
# Property page
# -------------------
class TagsPropertyPage(GObject.GObject, Nautilus.PropertyPageProvider):
  def __init__(self):
    pass

  # method to set one label in the table
  def SetLabel(self, value, row, column, width, align):
    # create label
    labelValue = Gtk.Label()
    labelValue.set_markup(value)

    # set alignment
    if align == "left": labelValue.set_alignment(xalign=0.0, yalign=0.0)
    if align == "center": labelValue.set_alignment(xalign=0.5, yalign=0.0)
    if align == "right": labelValue.set_alignment(xalign=1.0, yalign=0.0)

    # place label
    self.table.attach(labelValue, column, column + width, row, row + 1)
    return

  # method to generate properties tab
  def get_property_pages(self, files):
    # default map size and zoom factor
    sizeMap = '320x320'
    zoomMap = '10'
  
    # if dealing with multiple selection, return
    if len(files) != 1:
      return

    # if not dealing with file, return
    file = files[0]
    if file.get_uri_scheme() != 'file':
      return

    # if mimetype corresponds to JPG image, read data and populate tab
    if file.get_mime_type() in ('image/jpeg' 'image/png'):
    
      # read data from APK file
      filename = urllib.unquote(file.get_uri()[7:])

      # get metadata
      self.tags = GExiv2.Metadata(filename)

      # create table
      self.table = Gtk.Table(len(self.tags), 2)

      # set spacing
      self.table.set_col_spacings(10)
      self.table.set_row_spacings(5)

      # set margins
      self.table.set_margin_start(10)
      self.table.set_margin_end(10)
      self.table.set_margin_top(10)
      self.table.set_margin_bottom(10)

      index = 0
      for (val) in self.tags:
        self.SetLabel("<b>" + val + "</b>", index, 0, 1, "right")
        self.SetLabel(self.tags[val], index, 1, 1, "left")
        index = index + 1

      # set tab content (scrolled window -> table)
      tab_win = Gtk.ScrolledWindow()
      tab_win.add_with_viewport(self.table)
      tab_win.show_all()

      # set tab label
      tab_label = Gtk.Label('Tags')

      # return label and tab content
      return Nautilus.PropertyPage( name="NautilusPython::tags_info", label=tab_label, page=tab_win ),
