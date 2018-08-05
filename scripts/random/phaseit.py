#!/usr/bin/python

import random
import re
import sys

top = {"R":"A","Y":"C","S":"G","W":"A",
"K":"G","M":"A"}

bottom = {"R":"G","Y":"T","S":"C","W":"T",
"K":"T","M":"C"}

def multiple_replace(dict,text):
  regex = re.compile("(%s)" % "|".join(map(re.escape, dict.keys())))
  return regex.sub(lambda mo: dict[mo.string[mo.start():mo.end()]], text)

file = sys.argv[1]

f = open(file+".phy",'r')
content = f.readlines()
f.close()
f2 = open(file+"-phased.phy",'w')
for i in range(len(content)):
  sample = random.random()
  if sample >= 0.5:
    linesub = multiple_replace(top,content[i])
    f2.write(linesub)
  else:
    linesub = multiple_replace(bottom,content[i])
    f2.write(linesub)
f2.close()
  
