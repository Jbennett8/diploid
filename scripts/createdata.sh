#!/bin/bash
#script to create the necessary 2400 datasets for later bpp analysis
#run createdirs.sh first, or comment out the line moving each file into a directory if you want everything in one place

symmetry='A'  #A=symmetrical B=unsymmetrical
loci='10L'
number=1      #replicates
rate='high'   #low=(tau,theta) * 0.1

treeA='(((((((A #0.01, B #0.01):0.01 #0.01, C #0.01):0.015 #0.01, D #0.01):0.02 #0.01, E #0.01):0.025 #0.01, F #0.01):0.03 #0.01, G #0.01):0.035 #0.01, H #0.01):0.04 #0.01;'

treeAlow='(((((((A #0.001, B #0.001):0.001 #0.001, C #0.001):0.0015 #0.001, D #0.001):0.002 #0.001, E #0.001):0.0025 #0.001, F #0.001):0.003 #0.001, G #0.001):0.0035 #0.001, H #0.001):0.004 #0.001;'

treeB='(((A #0.01, B #0.01):0.01 #0.01,(C #0.01, D #0.01):0.018 #0.01):0.02 #0.01,((E #0.01, F #0.01):0.01 #0.01, (G #0.01, H #0.01):0.018 #0.01):0.02 #0.01):0.03 #0.01;'
treeBlow='(((A #0.001, B #0.001):0.001 #0.001,(C #0.001, D #0.001):0.0018 #0.001):0.002 #0.001,((E #0.001, F #0.001):0.001 #0.001, (G #0.001, H #0.001):0.0018 #0.001):0.002 #0.001):0.003 #0.001;'

MCcounter=1

for trees in {1..2}
do
  if (( trees == 2 ))
  then
    sed -i "6 c $treeB" MCcoal.ctl
    symmetry='B'
  else
    sed -i "6 c $treeA" MCcoal.ctl
  fi
  for loci in {1..3}
  do
    if (( loci == 1 ))
    then
      sed -i '9s/[0-9]\{2,3\}/10/' MCcoal.ctl
      loci='10L'
    elif (( loci == 2 ))
    then
      sed -i '9s/[0-9]\{2,3\}/50/' MCcoal.ctl
      loci='50L'
    elif (( loci == 3 ))
    then
      sed -i '9s/[0-9]\{2,3\}/250/' MCcoal.ctl
      loci='250L'
    fi
    for replicates in {1..100}
    do
      number=$replicates
      for rates in {1..2}
      do
        if (( rates == 2 )) && (( trees == 2 ))
        then
          sed -i "6 c $treeBlow" MCcoal.ctl
          rate='low'
        elif (( rates == 2 )) && (( trees == 1 ))
        then
          sed -i "6 c $treeAlow" MCcoal.ctl
          rate='low'
        elif (( rates == 1 )) && (( trees == 1 ))
        then
          sed -i "6 c $treeA" MCcoal.ctl
          rate='high'
        else
          sed -i "6 c $treeB" MCcoal.ctl
          rate='high'
        fi
        sed -i "2 c seqfile = $symmetry-$loci-$rate-$number.txt 0" MCcoal.ctl
        sed -i "1s/[0-9]\+/$RANDOM/" MCcoal.ctl
        sleep 1
        cat MCcoal.ctl > ../../../MCcoalfiles/MCcoal$MCcounter.ctl
        ((MCcounter++))
        /tmp/MCcoal MCcoal.ctl
        mv "$symmetry-$loci-$rate-$number.txt" "$symmetry/$loci/$rate" #comment this out to put everything in one directory 
      done
    done
  done
done
