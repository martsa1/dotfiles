#!/bin/bash

wget https://github.com/atom/atom/releases/latest -O /tmp/latest
downLink=$(awk -F '[<>]' '/href=".*atom-amd64.deb/ {match($0,"href=\"(.*.deb)\"",a); print "https://github.com/" a[1]} ' /tmp/latest)
latestVer=$(awk -F '[<>]' '/href=".*atom-amd64.deb/ {match($0,"href=\".*([0-9]+.[0-9]+.[0-9]+).*.deb\"",a); print a[1]} ' /tmp/latest)
currentVer=$(atom --version)
echo -e "Current version: $currentVer, Latest Available: $latestVer."
read -p "Continue with Update?" continueOrNot
if [ $continueOrNot != "y" -a $continueOrNot != "Y" ]
  then
  echo -e "quitting"
  exit 1
fi

echo -e "Downlink: $downLink"

wget $downLink -O /tmp/atom-amd64.deb
sudo dpkg -i /tmp/atom-amd64.deb
