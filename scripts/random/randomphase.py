#!/usr/bin/python

import subprocess

for loci in "10L 50L 250L".split():
  for rate in "low high".split():
    for num in "1 2".split():
      for iter in "1 2 3".split():
        if iter=="1" and loci=="10L":
          niter="75"
          file ="random/"+loci+'/'+rate+'/'+num+'/'+niter+'/'+loci+'-'+rate+'-'+num
          subprocess.call("scripts/random/./phaseit.py "+file,shell=True)
        elif iter=="2" and loci=="10L":
          niter="200"
          file ="random/"+loci+'/'+rate+'/'+num+'/'+niter+'/'+loci+'-'+rate+'-'+num
          subprocess.call("scripts/random/./phaseit.py "+file,shell=True)
        elif iter=="3" and loci=="10L":
          niter="500"
          file ="random/"+loci+'/'+rate+'/'+num+'/'+niter+'/'+loci+'-'+rate+'-'+num
          subprocess.call("scripts/random/./phaseit.py "+file,shell=True)
        elif iter=="1":
          niter="30"
          file ="random/"+loci+'/'+rate+'/'+num+'/'+niter+'/'+loci+'-'+rate+'-'+num
          subprocess.call("scripts/random/./phaseit.py "+file,shell=True)
        elif iter=="2":
          niter="80"
          file ="random/"+loci+'/'+rate+'/'+num+'/'+niter+'/'+loci+'-'+rate+'-'+num
          subprocess.call("scripts/random/./phaseit.py "+file,shell=True)
        elif iter=="3":
          niter="200"
          file ="random/"+loci+'/'+rate+'/'+num+'/'+niter+'/'+loci+'-'+rate+'-'+num
          subprocess.call("scripts/random/./phaseit.py "+file,shell=True)

         
