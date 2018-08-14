#!/usr/bin/python

import subprocess

locilist="10L 50L 250L"

for tree in "U B".split():
  for loci in locilist.split():
    for rate in "low high".split():
      for repl in range(1,101):
        file = tree+'/random/'+loci+'/'+rate+'/'+str(repl)+'/'+tree+'-'+'random'+'-'+loci+'-'+rate+'-'+str(repl)
        print(file)
        subprocess.call("scripts/random/./randomsubmit.py "+file,shell=True)
    
