#!/usr/bin/python

import subprocess

for loci in "10L 50L 250L".split():
  for rate in "low high".split():
    for num in "1 2".split():
      for iter in "15 40 100".split():
        file ="random/"+loci+'/'+rate+'/'+num+'/'+iter+'/'+loci+'-'+rate+'-'+num
        subprocess.call("scripts/random/./phaseit.py "+file,shell=True)
         
