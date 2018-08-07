#!/usr/bin/python

import subprocess
import os
import re

basedir=os.getcwd()

analyses = {'10L-low-75' : [],
'10L-low-200' : [],
'10L-low-500' : [],
'10L-high-75' : [],
'10L-high-200' : [],
'10L-high-500' : [],
'50L-low-30' : [],
'50L-low-80' : [],
'50L-low-200' : [],
'50L-high-30' : [],
'50L-high-80' : [],
'50L-high-200' : [],
'250L-low-30' : [],
'250L-low-80' : [],
'250L-low-200' : [],
'250L-high-30' : [],
'250L-high-80' : [],
'250L-high-200' : [],}

for method in "fulldata diploidoption random".split():
  for loci in "10L 50L 250L".split():
    for rate in "low high".split():
      for num in "1 2".split():
        for iter in "30 80 200".split():
          if loci=="10L":
            iter = int(iter)
            iter*=2.5
            iter = int(iter)
            iter = str(iter)
          dir = basedir+'/'+method+'/'+loci+'/'+rate+'/'+num+'/'+iter
          os.chdir(dir)
          file = loci+'-'+rate+'-'+num+'-'+iter+"-out.txt"
          f = open(file,'r')
          content = f.readlines()
          f.close()
          lastline = len(content)-1
          if lastline == -1:
            print("file %s is being written to" % file)
          else:
            m = re.match("(.*);.*([0-9]\.[0-9]*)",content[lastline])
            if m == None:
              print("file %s is wrong" % file)
            else:
              s = re.sub("#[0-9]\.[0-9]*","",m.group(1))
              key = loci+'-'+rate+'-'+iter
              analyses[key].append((s,m.group(2)))

os.chdir(basedir)
f=open("summary.txt",'w')

f.write(" "*15)
f.write("fulldata-1"+" "*47+"fulldata-2"+" "*46+"diploidoption-1"+" "*41+"diploidoption-2"+" "*41+"PHASE-1"+" "*49+"PHASE-2"+" "*49+"random-1"+" "*48+"random-2")
f.write("\n")

for loci in "10L 50L 250L".split():
  for rate in "low high".split():
    for iter in "30 80 200".split():
       if loci=="10L":
         iter = int(iter)
         iter*=2.5
         iter = int(iter)
         iter = str(iter)
       key = loci+'-'+rate+'-'+iter
       line = analyses[key]
       f.write(key+": ")
       longest = len("250L-high-200")
       if len(key) < longest: #make it nice
         diff = longest-len(key)
         for i in range(diff):
           f.write(" ")
       for i in line:
         f.write(" ".join(i))
         f.write(" \t")
       f.write("\n")
f.close()

