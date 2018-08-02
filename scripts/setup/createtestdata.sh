treeA='(((((((A #0.01, B #0.01):0.01 #0.01, C #0.01):0.015 #0.01, D #0.01):0.02 #0.01, E #0.01):0.025 #0.01, F #0.01):0.03 #0.01, G #0.01):0.035 #0.01, H #0.01):0.04 #0.01;'

treeAlow='(((((((A #0.001, B #0.001):0.001 #0.001, C #0.001):0.0015 #0.001, D #0.001):0.002 #0.001, E #0.001):0.0025 #0.001, F #0.001):0.003 #0.001, G #0.001):0.0035 #0.001, H #0.001):0.004 #0.001;'

Seeds=(23498 11884 25259 533 23126 26411 16251 14814 20214 1996 7226 20679)
Seedcounter=0
loci="10L"
rate="low"
rep="1"
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
    for nrep in {1..2}
    do
      if (( Seedcounter == 12 ))
      then
        Seedcounter=0
      fi
      next=${Seeds[$Seedcounter]}
      ((Seedcounter++))
      if (( nrep == 1 ))
      then
        rep="1"
        sed -i "1 c seed = $next" MCcoal.ctl
        sed -i "2 c seqfile = $loci-$rate-$rep.phy 0" MCcoal.ctl
      else
        rep="2"
        sed -i "1 c seed = $next" MCcoal.ctl
        sed -i "2 c seqfile = $loci-$rate-$rep.phy 0" MCcoal.ctl
      fi
      for niter in {1..3}
      do
        if (( niter == 1 ))
        then
          iter='15'
          MCcoal.exe MCcoal.ctl
          cp MCcoal.ctl "$method/$loci/$rate/$rep/$iter/MCcoal.ctl"
          mv "Imap.txt" "$method/$loci/$rate/$rep/$iter/Imap.txt"
          mv "$loci-$rate-$rep.phy" "$method/$loci/$rate/$rep/$iter"
        elif (( niter == 2 ))
        then
          iter='40'
          MCcoal.exe MCcoal.ctl
          cp MCcoal.ctl "$method/$loci/$rate/$rep/$iter/MCcoal.ctl"
          mv "Imap.txt" "$method/$loci/$rate/$rep/$iter/Imap.txt"
          mv "$loci-$rate-$rep.phy" "$method/$loci/$rate/$rep/$iter"
        else
          iter='100'
          MCcoal.exe MCcoal.ctl
          cp MCcoal.ctl "$method/$loci/$rate/$rep/$iter/MCcoal.ctl"
          mv "Imap.txt" "$method/$loci/$rate/$rep/$iter/Imap.txt"
          mv "$loci-$rate-$rep.phy" "$method/$loci/$rate/$rep/$iter"
        fi
      done 
    done
  done
done
