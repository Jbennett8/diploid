#$ -S /usr/bin/python
#$ -l h_rt=10:0:0
#$ -l h_vmem=2G
#$ -l tmem=2G
#$ -cwd
#$ -N randomphaseresolution


import random
import re

first = {"R":"A","Y":"C","S":"G","W":"A",
"K":"G","M":"A"}

second = {"R":"G","Y":"T","S":"C","W":"T",
"K":"T","M":"C"}


locilist="10L 50L 250L"

sequenceline = re.compile("([a-h])1_2\^([A-H])")
lociline = re.compile("(\d)\s(\d+)")
for tree in "U B".split():
  for loci in locilist.split():
    for rate in "low high".split():
      for repl in range(1,101):
        file = tree+'/random/'+loci+'/'+rate+'/'+str(repl)+'/'+tree+'-'+'random'+'-'+loci+'-'+rate+'-'+str(repl)
        print(file)
        writephase = open(file+"-phased.phy",'w')
        with open(file+".phy",'r') as readf:
          c = readf.readlines()
        for line in c:
          sequencecheck = sequenceline.match(line)
          locicheck = lociline.match(line)
          if sequencecheck is not None:
            writelinetop = ""
            writelinebottom = ""
            for char in line[12:]:
              if char in first:
                sample = random.random() 
                if sample > 0.5:
                  top = first[char]
                  bottom = second[char]
                else:
                  top = second[char]
                  bottom = first[char]
                writelinetop+=top
                writelinebottom+=bottom
              else:
                writelinetop+=char
                writelinebottom+=char
            writephase.write(sequencecheck.group(1)+"1^"+sequencecheck.group(2)+" "*6+writelinetop)
            writephase.write(sequencecheck.group(1)+"2^"+sequencecheck.group(2)+" "*6+writelinebottom)
          elif locicheck is not None:
            writephase.write(str(int(locicheck.group(1))*2)+" "+locicheck.group(2)+"\n")
          else:
            writephase.write(line)
        writephase.close()
              
        
