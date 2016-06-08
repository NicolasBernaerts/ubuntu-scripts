# ---------------------------------------------------
# Nautilus extension to add XMP tags specific columns
# Procedure :
#   http://bernaerts.dyndns.org/linux/76-gnome/xxx
# Depends on :
#   * exiftool
# Revision history :
#   20/08/2015, V1.0 - Creation by N. Bernaerts
# ---------------------------------------------------
import subprocess
import urllib
import os
import re
import pipes
from gi.repository import Nautilus, GObject

class XMPColumnExtension(GObject.GObject, Nautilus.ColumnProvider, Nautilus.InfoProvider):
  def __init__(self):
    pass
    
  def get_data(self,filename):
    xmp_title = ""
    xmp_caption = ""
    xmp_city = ""
    xmp_country = ""
    xmp_date = ""
    xmp_keywords = ""

    command_line = "exiftool -G -s -args -xmp:all " + pipes.quote(filename)
    p = subprocess.Popen(command_line , shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)

    for line in p.stdout.readlines():
      # Title
      if xmp_title == "":
        regexpr = re.match('^-XMP:Title=.*$', line)
        if regexpr: 
          xmp_title = re.sub('^-XMP:Title=(.*)$', '\g<1>', line).rstrip('\n')

      # Description
      if xmp_caption == "":
        regexpr = re.match('^-XMP:Caption=.*$', line)
        if regexpr: 
          xmp_caption = re.sub('^-XMP:Caption=(.*)$', '\g<1>', line).rstrip('\n')

      # City
      if xmp_city == "":
        regexpr = re.match('^-XMP:City=.*$', line)
        if regexpr: 
          xmp_city = re.sub('^-XMP:City=(.*)$', '\g<1>', line).rstrip('\n')

      # Country
      if xmp_country == "":
        regexpr = re.match('^-XMP:Country=.*$', line)
        if regexpr: 
          xmp_country = re.sub('^-XMP:Country=(.*)$', '\g<1>', line).rstrip('\n')

      # Date
      if xmp_date == "":
        regexpr = re.match('^-XMP:CreateDate=.*$', line)
        if regexpr: 
          xmp_date = re.sub('^-XMP:CreateDate=(.*)$', '\g<1>', line).rstrip('\n')

      # Keywords
      if xmp_keywords == "":
        regexpr = re.match('^-XMP:Keywords=.*$', line)
        if regexpr: 
          xmp_keywords = re.sub('^-XMP:Keywords=(.*)$', '\g<1>', line).rstrip('\n')

    return xmp_title, xmp_caption, xmp_city, xmp_country, xmp_date, xmp_keywords

  def get_columns(self):
      return (
        Nautilus.Column(name="NautilusPython::XMPTagTitle", attribute="xmp_tag_title", label="XMP-Title", description="Title of document"),
        Nautilus.Column(name="NautilusPython::XMPTagCaption", attribute="xmp_tag_caption", label="XMP-Caption", description="Description of document"),
        Nautilus.Column(name="NautilusPython::XMPTagCity", attribute="xmp_tag_city", label="XMP-City", description="City of origin of document"),
        Nautilus.Column(name="NautilusPython::XMPTagCountry", attribute="xmp_tag_country", label="XMP-Country", description="Country of origin of document"),
        Nautilus.Column(name="NautilusPython::XMPTagDate", attribute="xmp_tag_date", label="XMP-Date", description="Date of creation of document"),
        Nautilus.Column(name="NautilusPython::XMPTagKeywords", attribute="xmp_tag_keywords", label="XMP-Keywords", description="Keywords of document"),
      )

  def update_file_info(self, file):
    if file.get_uri_scheme() != 'file':
      return
        
    if file.get_mime_type() in ('application/pdf' 'image/jpeg' 'image/png'):
      filename = urllib.unquote(file.get_uri()[7:])
      result = self.get_data(filename)
    else:
      result=("", "", "", "", "", "") 

    file.add_string_attribute('xmp_tag_title', result[0])
    file.add_string_attribute('xmp_tag_caption', result[1])
    file.add_string_attribute('xmp_tag_city', result[2])
    file.add_string_attribute('xmp_tag_country', result[3])
    file.add_string_attribute('xmp_tag_date', result[4])
    file.add_string_attribute('xmp_tag_keywords', result[5])
