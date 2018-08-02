#!/bin/bash
#creates necessary folders for the analyses
#runs scripts makedirs, and createtestdata with the options specified

if [ "$1" = "all" ]
then
  echo "Option all: create folders and data for all analyses #fulldata, diploidoption, PHASED, random#"
  pwd
  cp scripts/grab/MCcoal.exe MCcoal.exe  #grab ctl and exe to put in working directory
  cp scripts/grab/MCcoal.ctl MCcoal.ctl
  scripts/setup/./makedirs.sh
  scripts/setup/./createtestdata.sh fulldata
  scripts/setup/./createtestdata.sh diploidoption
  scripts/setup/./createtestdata.sh PHASED
  scripts/setup/./createtestdata.sh random
  rm MCcoal.exe #tidy up
  rm MCcoal.ctl
else
  echo "Options are: all"
fi
