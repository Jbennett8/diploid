#! /bin/bash
#$ -S /bin/bash
#$ -l h_vmem=2G
#$ -l h_rt=10:0:0
#$ -l tmem=2G
#$ -cwd
#creates necessary folders for the analyses
#runs scripts makedirs, and createtestdata with the options specified

function fulldata {
  echo "Creating folders for fulldata analysis"
  scripts/setup/./makedirs.sh fulldata 
  echo "Populating folders with MCcoal simulated data"
  cp scripts/setup/MCcoal.exe MCcoal.exe
  cp scripts/setup/MCcoal.ctl MCcoal.ctl
  scripts/setup/./createtestdata.sh fulldata
  rm MCcoal.exe
  rm MCcoal.ctl
}

function diploidoption {
  echo "Creating folders for diploidoption analysis"
  scripts/setup/./makedirs.sh diploidoption
  echo "Populating folders with MCcoal simulated data"
  cp scripts/setup/MCcoal.exe MCcoal.exe
  cp scripts/setup/MCcoal.ctl MCcoal.ctl
  scripts/setup/./createtestdata.sh diploidoption
  rm MCcoal.exe
  rm MCcoal.ctl
}

function PHASE {
  echo "Creating folders for PHASE analysis"
  scripts/setup/./makedirs.sh PHASE 
  echo "Populating folders with MCcoal simulated data"
  cp scripts/setup/MCcoal.exe MCcoal.exe
  cp scripts/setup/MCcoal.ctl MCcoal.ctl
  scripts/setup/./createtestdata.sh PHASED
  rm MCcoal.exe
  rm MCcoal.ctl
  echo "Phasing diploid data using PHASE algorithm"
  scripts/PHASE/./use_PHASE.sh
  echo "Phasing using PHASE scripts submitted to cluster"
  echo "Bpp analyses can be run when the cluster submissions complete"
}

function randomfunc {
  echo "Creating folders for random analysis"
  scripts/setup/./makedirs.sh random
  echo "Populating folders with MCcoal simulated data"
  cp scripts/setup/MCcoal.exe MCcoal.exe
  cp scripts/setup/MCcoal.ctl MCcoal.ctl
  scripts/setup/./createtestdata.sh random
  echo "Phasing diploid data randomly via haploid consensus sequence"
  scripts/random/./randomphase.py
  echo "Done"
}

if [ "$1" = "all" ]
then
  echo "Option all: create folders and data for all analyses #fulldata, diploidoption, PHASED, random#"
  cp scripts/setup/MCcoal.exe MCcoal.exe  #grab ctl and exe to put in working directory
  cp scripts/setup/MCcoal.ctl MCcoal.ctl
  scripts/setup/./makedirs.sh all
  scripts/setup/./createtestdata.sh fulldata
  scripts/setup/./createtestdata.sh diploidoption
  scripts/setup/./createtestdata.sh PHASED
  scripts/setup/./createtestdata.sh random
#  find PHASED/ -type d -exec chmod 755 {} \;
  echo "Phasing using PHASE and creating haploid consensus sequences"
  scripts/random/./randomphase.py
  scripts/PHASE/./use_PHASE.sh
  echo 'Bpp analyses can be run when the "phasing.sh" cluster submissions complete'
  rm MCcoal.exe #tidy up
  rm MCcoal.ctl
elif [ "$1" = "fulldata" ]
then
  fulldata
elif [ "$1" = "PHASE" ]
then
  PHASE
elif [ "$1" = "diploidoption" ]
then
  diploidoption
elif [ "$1" = "random" ]
then
  randomfunc
else
  echo "Options are: all, fulldata, diploidoption, PHASE, random"
fi
