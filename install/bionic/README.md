Ubuntu Bionic post-installation scripts
=======================================

Here are the scripts I use to automatise installation of an Ubuntu Bionic workstation.

Main script to be called is **post-install**. As it needs to run some **sudo** commands to install packages, you'll be prompted for your session password.

It takes few parameters according to the options you want.

| Option             | Description |
| -------------      | ------------- |
| **--docky**        | Add docky launcher |
| **--wifi**         | Add some tweaks for problematic wifi cards |
| **--ssd**          | Add some tweaks for SSD disk |
| **--gopro**        | Add GoPro bug correction |
| **--hp-printer**   | Add HP printers GUI |
| **--no-junk**      | Remove junk package (Amazon launcher) |

This script call various specialized script in charge of installing latest tools for :
  * utilities
  * office work
  * graphical and design
  * multimedia
  * internet
  * android connectivity

Some of these post-installation operations are explained in details in various articles available under http://bernaerts.dyndns.org/linux/

Typical post Ubuntu installation command is :

    # wget https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/install/bionic/post-install
    # chmod +x ./post-install
    # ./post-install --docky --gopro
