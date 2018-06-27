#!/bin/bash
#script to create the necessary 2400 datasets for later bpp analysis


symmetry='A'  #A=symmetrical B=unsymmetrical
loci='10L'
number=1      #replicates
rate='high'   #low=(tau,theta) * 0.1
seq=1

treeAlow='(((((((A #0.001, B #0.001):0.001 #0.001, C #0.001):0.0015 #0.001, D #0.001):0.002 #0.001, E #0.001):0.0025 #0.001, F #0.001):0.003 #0.001, G #0.001):0.0035 #0.001, H #0.001):0.004 #0.01;'

treeB='(((A #0.01, B #0.01):0.01 #0.01,(C #0.01, D #0.01):0.018 #0.01):0.02 #0.01,((E #0.01, F #0.01):0.01 #0.01, (G #0.01, H #0.01):0.018 #0.01):0.02 #0.01):0.03 #0.01;'
treeBlow='(((A #0.001, B #0.001):0.001 #0.001,(C #0.001, D #0.001):0.0018 #0.001):0.002 #0.001,((E #0.001, F #0.001):0.001 #0.001, (G #0.001, H #0.001):0.0018 #0.001):0.002 #0.001):0.003 #0.001;'


for trees in {1..2}
do
  if (( trees == 2 ))
  then
    sed -i "6 c $treeB" MCcoal.ctl
    symmetry='B'
  fi
  for loci in {1..3}
  do
    if (( loci == 2 ))
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
        else
          rate='high'
        fi
        for sequences in {1..2}
        do
	  if (( sequences == 2 ))
          then
            sed -i '5s/1/2/g' MCcoal.ctl
            seq=2
          fi
          sed -i "2 c seqfile = $symmetry-$loci-$number-$rate-$seq.txt 0" MCcoal.ctl
          /tmp/MCcoal MCcoal.ctl
        done
      done
    done
  done
done
