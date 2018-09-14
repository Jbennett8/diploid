#!/usr/bin/python

import sys
import argparse
import re
import os

notfound=[]

methodlist = 'fulldata,diploidoption,PHASED,random'
locilist = '10,50,250'

for i in range(len(sys.argv)):
  if (sys.argv[i] == '-m'):
    methodlist = sys.argv[i+1]
  if (sys.argv[i] == '-l'):
    locilist = sys.argv[i+1]

if len(sys.argv) == 1:
  print("No options specified, checking default loci and methods for completed analyses")

print("Loci specified %s" % locilist)
print("Methods specified %s" % methodlist)

for tree in "U B".split():
  for method in methodlist.split(","):
    for loci in locilist.split(","):
      for rate in "low high".split():
        for repl in range(1,101):
          file = tree+'/'+method+'/'+loci+"L"+'/'+rate+'/'+str(repl)+'/'+"out.txt"
          try:
            f = open(file,'r')
            content = f.readlines()
            if len(content) == 0:
              notfound.append(file) #out file never written to
            else:
              lastline = len(content)-1
              m = re.match("(.*);.*([0-9]\.[0-9]*)",content[lastline])
              if m is None: #out file never completed
                notfound.append(file)
          except IOError: #out file never created
            notfound.append(file)

print("%d Analyses uncompleted" % len(notfound))

f2=open("notfound.txt",'w')

for i in notfound:
  f2.write(i+"\n")

f2.close()
