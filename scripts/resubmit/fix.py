#!/usr/bin/python

import os,subprocess

basedir = "/SAN/yanglab/abacus/jeremy/git/diploid/newscript/" #change to match directory containing all datasets
bpp = "/SAN/yanglab/abacus/jeremy/bpp4.0/bpp.exe" #change to match your installation directory of bpp

f = open("notfound.txt",'r')
analyses = f.readlines()
f.close()

os.chdir("scripts/qsub")

f2 = open("runonce.txt",'r')
submit = f2.readlines()

for i,line in enumerate(analyses):
  dir = line[:-8]
  f3 = open("temp.txt",'w')
  for j,l in enumerate(submit):
    if (j==4):
      f3.write("#$ -wd %s \n" % (basedir+dir))
    elif (j==7):
      f3.write("#$ -N %s \n" % (dir.replace("/",".")))
    elif (j==9):
      f3.write("%s --cfile A01.bpp.ctl > log.txt" % bpp)
    else:
      f3.write(l)
  f3.close()
  subprocess.call("qsub temp.txt",shell=True)
  print("Done with %d" % i)
