#!/usr/bin/env bash

repodir="/home/ghost/pbuilder/repo"
cachedir="/home/ghost/pbuilder/result/amd64/"

mkdir -p $repodir

for paquete in `ls $cachedir`
do

nompaq=$(echo "$paquete" | cut -d'_' -f1 | cut -d'.' -f1 | cut -d'-' -f1)

mkdir -p $repodir/${paquete:0:1}/$nompaq

cp $cachedir/$paquete $repodir/${paquete:0:1}/$nompaq/$paquete

echo "Copiado $paquete en ${paquete:0:1}/$nompaq"

done


sudo dpkg-scansources $repodir /dev/null > $repodir/Sources
sudo dpkg-scanpackages $repodir /dev/null > $repodir/Packages
apt-ftparchive release $repodir > $repodir/Release

gpg -abs -o $repodir/Release.gpg $repodir/Release

sudo apt-get update

echo "Terminado correctamente"

