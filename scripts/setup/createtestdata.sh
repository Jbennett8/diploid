treeA='(((((((A #0.01, B #0.01):0.01 #0.01, C #0.01):0.012 #0.01, D #0.01):0.02 #0.01, E #0.01):0.025 #0.01, F #0.01):0.03 #0.01, G #0.01):0.032 #0.01, H #0.01):0.04 #0.01;'

treeAlow='(((((((A #0.001, B #0.001):0.001 #0.001, C #0.001):0.0012 #0.001, D #0.001):0.002 #0.001, E #0.001):0.0025 #0.001, F #0.001):0.003 #0.001, G #0.001):0.0032 #0.001, H #0.001):0.004 #0.001;'

loci="10L"
rate="low"
iter="15"

if [ "$1" = "diploidoption" ]
then
  sed -i "5 c 1 1 1 1 1 1 1 1" MCcoal.ctl
  sed -i "8 c diploid = 1 1 1 1 1 1 1 1" MCcoal.ctl
  method="diploidoption"
elif [ "$1" = "PHASED" ]
then
  sed -i "5 c 1 1 1 1 1 1 1 1" MCcoal.ctl
  sed -i "8 c diploid = 1 1 1 1 1 1 1 1" MCcoal.ctl
  method="PHASED"
elif [ "$1" = "fulldata" ]
then
  sed -i "5 c 2 2 2 2 2 2 2 2" MCcoal.ctl
  sed -i "8 c diploid = 0 0 0 0 0 0 0 0" MCcoal.ctl
  method="fulldata"
elif [ "$1" = "random" ]
then
  sed -i "5 c 1 1 1 1 1 1 1 1" MCcoal.ctl
  sed -i "8 c diploid = 1 1 1 1 1 1 1 1" MCcoal.ctl
  method="random"
else
  echo "options accepted: diploidoption,PHASED,fulldata,random"
  exit 1
fi


for nloci in {1..3}
do
  if (( nloci == 1 ))
  then
    loci="10L"
    sed -i "9 c loci&length=10 500" MCcoal.ctl
  elif (( nloci == 2 ))
  then
    loci="50L"
    sed -i "9 c loci&length=50 500" MCcoal.ctl
  else
    loci="250L"
    sed -i "9 c loci&length=250 500" MCcoal.ctl
  fi
  for rates in {1..2}
  do
    if (( rates == 1 ))
    then
      rate="low"
      sed -i "6 c $treeAlow" MCcoal.ctl
    else
      rate="high"
      sed -i "6 c $treeA" MCcoal.ctl
    fi
    sed -i "1 c seed = $RANDOM" MCcoal.ctl
    for nrep in {1..2}
    do
      sed -i "2 c seqfile = $loci-$rate-$nrep.phy 0" MCcoal.ctl
      for niter in {1..3}
      do
        if (( niter == 1 ))
        then
          iter='15'
          MCcoal.exe MCcoal.ctl
          cp MCcoal.ctl "$method/$loci/$rate/$nrep/$iter/MCcoal.ctl"
          mv "Imap.txt" "$method/$loci/$rate/$nrep/$iter/Imap.txt"
          mv "$loci-$rate-$nrep.phy" "$method/$loci/$rate/$nrep/$iter"
        elif (( niter == 2 ))
        then
          iter='40'
          MCcoal.exe MCcoal.ctl
          cp MCcoal.ctl "$method/$loci/$rate/$nrep/$iter/MCcoal.ctl"
          mv "Imap.txt" "$method/$loci/$rate/$nrep/$iter/Imap.txt"
          mv "$loci-$rate-$nrep.phy" "$method/$loci/$rate/$nrep/$iter"
        else
          iter='100'
          MCcoal.exe MCcoal.ctl
          cp MCcoal.ctl "$method/$loci/$rate/$nrep/$iter/MCcoal.ctl"
          mv "Imap.txt" "$method/$loci/$rate/$nrep/$iter/Imap.txt"
          mv "$loci-$rate-$nrep.phy" "$method/$loci/$rate/$nrep/$iter"
        fi
      done 
    done
  done
done
