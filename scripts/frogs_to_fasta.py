#! /usr/bin/python
'''
Converts format similar to frogs.phy bpp example data to fasta format
usage: ./frogs_to_fasta file.phy
'''

import sys
import re

name = sys.argv[1].split(".")
f = open(sys.argv[1],'r')
content = f.readlines()
f.close()

loci = []
species = []
data = []

for i in range(len(content)):
  m = re.match(r"(\d+)",content[i])
  m2 = re.match(r"[\^]",content[i]) 
  if m is not None:
    loci.append(m.group(1))
  if m2 is not None:
    split = content[i].split()
    species.append(split[0])
    data.append(split[1])

print "%d files written, %d lines total" % (len(loci),len(species)*2)

for j in range(len(loci)):
  f2 = open(name[0]+"--locus"+str(j+1)+".fas",'w')
  for k in range(int(loci[j])):
    f2.write(">"+species.pop(0)+"\n"+data.pop(0)+"\n")
  f2.close()
