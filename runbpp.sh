basedir="$PWD"
bppdir="/SAN/yanglab/abacus/jeremy/bpp4.0"
loci="10L"
rate="low"
num="1"
iter="15"


cp scripts/qsub/A01.bpp.ctl
cp scripts/qsub/run.txt
if [ "$1" = "fulldata" ]
then
  method="fulldata"
  echo "Using fulldata method"
  sed -i "10 c 2 2 2 2 2 2 2 2" "$basedir/A01.bpp.ctl"
  sed -i "12 c diploid = 0 0 0 0 0 0 0 0" "$basedir/A01.bpp.ctl"
  sed -i "6 c \#$ $basedir/output/fulldata" run.txt
  sed -i "7 c \#$ $basedir/error/fulldata" run.txt
  for i in {1..3}
  do
    if (( i == 1 ))
    then
      loci="10L"
      sed -i "14 c nloci = 10" "$basedir/A01.bpp.ctl"
    elif (( $i == 2 ))
    then
      loci="50L"
      sed -i "14 c nloci = 50" "$basedir/A01.bpp.ctl"
    else
      loci="250L"
      sed -i "14 c nloci = 250" "$basedir/A01.bpp.ctl"
    fi
    for j in {1..2}
    do
      if (( j == 1 ))
      then
        rate="low"
        sed -i "17 c tauprior = 3 0.008" "$basedir/A01.bpp.ctl"
      else
        rate="high"
        sed -i "17 c tauprior = 3 0.08" "$basedir/A01.bpp.ctl"
      fi
      for k in {1..2}
      do
        if (( k == 1 ))
        then
          num="1"
        else
          num="2"
        fi
        for l in {1..3}
        do
          if (( l == 1 )) && [ $loci = "10L" ]
          then
            iter="75"
            sed -i "22 c nsample = 75000" "$basedir/A01.bpp.ctl"
            sed -i "20 c burnin = 7500" "$basedir/A01.bpp.ctl"
          elif (( l == 2 )) && [ $loci = "10L" ]
          then
            iter="200"
            sed -i "22 c nsample = 200000" "$basedir/A01.bpp.ctl"
            sed -i "20 c burnin = 20000" "$basedir/A01.bpp.ctl"
          elif (( l == 3 )) && [ $loci = "10L" ]
          then
            iter="500"
            sed -i "22 c nsample = 500000" "$basedir/A01.bpp.ctl"
            sed -i "20 c burnin = 50000" "$basedir/A01.bpp.ctl"
          elif (( l == 1 ))
          then
            iter="30"
            sed -i "22 c nsample = 30000" "$basedir/A01.bpp.ctl"
            sed -i "20 c burnin = 3000" "$basedir/A01.bpp.ctl"
          elif (( l == 2 ))
          then
            iter="80"
            sed -i "22 c nsample = 80000" "$basedir/A01.bpp.ctl"
            sed -i "20 c burnin = 8000" "$basedir/A01.bpp.ctl"
          else
            iter="200"
            sed -i "22 c nsample = 200000" "$basedir/A01.bpp.ctl"
            sed -i "20 c burnin = 20000" "$basedir/A01.bpp.ctl"
          fi
          bppctlfiledest="$basedir/$method/$loci/$rate/$num/$iter"
          sed -i "1 c seed = $RANDOM" "$basedir/A01.bpp.ctl"
          sed -i "2 c seqfile = $bppctlfiledest/$loci-$rate-$num.phy" "$basedir/A01.bpp.ctl"
          sed -i "3 c Imapfile = $bppctlfiledest/Imap.txt" "$basedir/A01.bpp.ctl"
          sed -i "4 c outfile = $bppctlfiledest/$loci-$rate-$num-$iter-out.txt" "$basedir/A01.bpp.ctl"
          sed -i "5 c mcmcfile = $bppctlfiledest/$loci-$rate-$num-$iter-mcmc.txt" "$basedir/A01.bpp.ctl"
          cp "$basedir/A01.bpp.ctl" "$bppctlfiledest/A01.bpp.ctl"
          sed -i "10 c $bppdir/bpp.exe --cfile $bppctlfiledest/A01.bpp.ctl" run.txt
          sed -i "9 c echo \$SECONDS > $bppctlfiledest/timeelapsed.txt" run.txt
          sed -i "11 c echo \$SECONDS >> $bppctlfiledest/timeelapsed.txt" run.txt
          cp "$basedir/run.txt" "$bppctlfiledest/run.txt"
          qsub "$bppctlfiledest/run.txt"
        done
      done
    done
  done
elif [ "$1" = "PHASE" ]
then
  method="PHASED"
  echo "Resolving phase using PHASE method"
  sed -i "10 c 2 2 2 2 2 2 2 2" "$basedir/A01.bpp.ctl"
  sed -i "12 c diploid = 0 0 0 0 0 0 0 0" "$basedir/A01.bpp.ctl"
  sed -i "7 c \#$ -o $basedir/output/PHASED" run.txt
  sed -i "6 c \#$ -e $basedir/error/PHASED" run.txt
  for i in {1..3}
  do
    if (( i == 1 ))
    then
      loci="10L"
      sed -i "14 c nloci = 10" "$basedir/A01.bpp.ctl"
    elif (( $i == 2 ))
    then
      loci="50L"
      sed -i "14 c nloci = 50" "$basedir/A01.bpp.ctl"
    else
      loci="250L"
      sed -i "14 c nloci = 250" "$basedir/A01.bpp.ctl"
    fi
    for j in {1..2}
    do
      if (( j == 1 ))
      then
        rate="low"
        sed -i "17 c tauprior = 3 0.008" "$basedir/A01.bpp.ctl"
      else
        rate="high"
        sed -i "17 c tauprior = 3 0.08" "$basedir/A01.bpp.ctl"
      fi
      for k in {1..2}
      do
        if (( k == 1 ))
        then
          num="1"
        else
          num="2"
        fi
        for l in {1..3}
        do
          if (( l == 1 )) && [ $loci = "10L" ]
          then
            iter="75"
            sed -i "22 c nsample = 75000" "$basedir/A01.bpp.ctl"
            sed -i "20 c burnin = 7500" "$basedir/A01.bpp.ctl"
          elif (( l == 2 )) && [ $loci = "10L" ]
          then
            iter="200"
            sed -i "22 c nsample = 200000" "$basedir/A01.bpp.ctl"
            sed -i "20 c burnin = 20000" "$basedir/A01.bpp.ctl"
          elif (( l == 3 )) && [ $loci = "10L" ]
          then
            iter="500"
            sed -i "22 c nsample = 500000" "$basedir/A01.bpp.ctl"
            sed -i "20 c burnin = 50000" "$basedir/A01.bpp.ctl"
          elif (( l == 1 ))
          then
            iter="30"
            sed -i "22 c nsample = 30000" "$basedir/A01.bpp.ctl"
            sed -i "20 c burnin = 3000" "$basedir/A01.bpp.ctl"
          elif (( l == 2 ))
          then
            iter="80"
            sed -i "22 c nsample = 80000" "$basedir/A01.bpp.ctl"
            sed -i "20 c burnin = 8000" "$basedir/A01.bpp.ctl"
          else
            iter="200"
            sed -i "22 c nsample = 200000" "$basedir/A01.bpp.ctl"
            sed -i "20 c burnin = 20000" "$basedir/A01.bpp.ctl"
          fi
          bppctlfiledest="$basedir/$method/$loci/$rate/$num/$iter"
          sed -i "1 c seed = $RANDOM" "$basedir/A01.bpp.ctl"
          sed -i "2 c seqfile = $bppctlfiledest/$loci-$rate-$num-phased.phy" "$basedir/A01.bpp.ctl"
          sed -i "3 c Imapfile = $basedir/scripts/qsub/ImapPHASE.txt" "$basedir/A01.bpp.ctl"
          sed -i "4 c outfile = $bppctlfiledest/$loci-$rate-$num-$iter-out.txt" "$basedir/A01.bpp.ctl"
          sed -i "5 c mcmcfile = $bppctlfiledest/$loci-$rate-$num-$iter-mcmc.txt" "$basedir/A01.bpp.ctl"
          cp "$basedir/A01.bpp.ctl" "$bppctlfiledest/A01.bpp.ctl"
          sed -i "10 c $bppdir/bpp.exe --cfile $bppctlfiledest/A01.bpp.ctl" run.txt
          sed -i "9 c echo \$SECONDS > $bppctlfiledest/timeelapsed.txt" run.txt
          sed -i "11 c echo \$SECONDS >> $bppctlfiledest/timeelapsed.txt" run.txt
          cp "$basedir/run.txt" "$bppctlfiledest/run.txt"
          qsub "$bppctlfiledest/run.txt"
        done
      done
    done
  done

elif [ "$1" = "diploidoption" ]
then
  method="diploidoption"
  echo "Resolving phase using diploid option"
  sed -i "10 c 1 1 1 1 1 1 1 1" "$basedir/A01.bpp.ctl"
  sed -i "12 c diploid = 1 1 1 1 1 1 1 1" "$basedir/A01.bpp.ctl"
  sed -i "6 c \#$ -o $basedir/output/diploidoption" run.txt
  sed -i "7 c \#$ -e $basedir/error/diploidoption" run.txt
  for i in {1..3}
  do
    if (( i == 1 ))
    then
      loci="10L"
      sed -i "14 c nloci = 10" "$basedir/A01.bpp.ctl"
    elif (( $i == 2 ))
    then
      loci="50L"
      sed -i "14 c nloci = 50" "$basedir/A01.bpp.ctl"
    else
      loci="250L"
      sed -i "14 c nloci = 250" "$basedir/A01.bpp.ctl"
    fi
    for j in {1..2}
    do
      if (( j == 1 ))
      then
        rate="low"
        sed -i "17 c tauprior = 3 0.008" "$basedir/A01.bpp.ctl"
      else
        rate="high"
        sed -i "17 c tauprior = 3 0.08" "$basedir/A01.bpp.ctl"
      fi
      for k in {1..2}
      do
        if (( k == 1 ))
        then
          num="1"
        else
          num="2"
        fi
        for l in {1..3}
        do
          if (( l == 1 )) && [ $loci = "10L" ]
          then
            iter="75"
            sed -i "22 c nsample = 75000" "$basedir/A01.bpp.ctl"
            sed -i "20 c burnin = 7500" "$basedir/A01.bpp.ctl"
          elif (( l == 2 )) && [ $loci = "10L" ]
          then
            iter="200"
            sed -i "22 c nsample = 200000" "$basedir/A01.bpp.ctl"
            sed -i "20 c burnin = 20000" "$basedir/A01.bpp.ctl"
          elif (( l == 3 )) && [ $loci = "10L" ]
          then
            iter="500"
            sed -i "22 c nsample = 500000" "$basedir/A01.bpp.ctl"
            sed -i "20 c burnin = 50000" "$basedir/A01.bpp.ctl"
          elif (( l == 1 ))
          then
            iter="30"
            sed -i "22 c nsample = 30000" "$basedir/A01.bpp.ctl"
            sed -i "20 c burnin = 3000" "$basedir/A01.bpp.ctl"
          elif (( l == 2 ))
          then
            iter="80"
            sed -i "22 c nsample = 80000" "$basedir/A01.bpp.ctl"
            sed -i "20 c burnin = 8000" "$basedir/A01.bpp.ctl"
          else
            iter="200"
            sed -i "22 c nsample = 200000" "$basedir/A01.bpp.ctl"
            sed -i "20 c burnin = 20000" "$basedir/A01.bpp.ctl"
          fi
          bppctlfiledest="$basedir/$method/$loci/$rate/$num/$iter"
          sed -i "1 c seed = $RANDOM" "$basedir/A01.bpp.ctl"
          sed -i "2 c seqfile = $bppctlfiledest/$loci-$rate-$num.phy" "$basedir/A01.bpp.ctl"
          sed -i "3 c Imapfile = $bppctlfiledest/Imap.txt" "$basedir/A01.bpp.ctl"
          sed -i "4 c outfile = $bppctlfiledest/$loci-$rate-$num-$iter-out.txt" "$basedir/A01.bpp.ctl"
          sed -i "5 c mcmcfile = $bppctlfiledest/$loci-$rate-$num-$iter-mcmc.txt" "$basedir/A01.bpp.ctl"
          cp "$basedir/A01.bpp.ctl" "$bppctlfiledest/A01.bpp.ctl"
          sed -i "10 c $bppdir/bpp.exe --cfile $bppctlfiledest/A01.bpp.ctl" run.txt
          sed -i "9 c echo \$SECONDS > $bppctlfiledest/timeelapsed.txt" run.txt
          sed -i "11 c echo \$SECONDS >> $bppctlfiledest/timeelapsed.txt" run.txt
          cp "$basedir/run.txt" "$bppctlfiledest/run.txt"
          qsub "$bppctlfiledest/run.txt"
        done
      done
    done
  done
elif [ "$1" = "random" ]
then
  method="random"
  echo "Resolving phase randomly as in haploid consensus sequence"
  sed -i "10 c 1 1 1 1 1 1 1 1" "$basedir/A01.bpp.ctl"
  sed -i "12 c diploid = 0 0 0 0 0 0 0 0" "$basedir/A01.bpp.ctl"
  sed -i "6 c \#$ -o $basedir/output/random" run.txt
  sed -i "7 c \#$ -e $basedir/error/random" run.txt
  for i in {1..3}
  do
    if (( i == 1 ))
    then
      loci="10L"
      sed -i "14 c nloci = 10" "$basedir/A01.bpp.ctl"
    elif (( $i == 2 ))
    then
      loci="50L"
      sed -i "14 c nloci = 50" "$basedir/A01.bpp.ctl"
    else
      loci="250L"
      sed -i "14 c nloci = 250" "$basedir/A01.bpp.ctl"
    fi
    for j in {1..2}
    do
      if (( j == 1 ))
      then
        rate="low"
        sed -i "17 c tauprior = 3 0.008" "$basedir/A01.bpp.ctl"
      else
        rate="high"
        sed -i "17 c tauprior = 3 0.08" "$basedir/A01.bpp.ctl"
      fi
      for k in {1..2}
      do
        if (( k == 1 ))
        then
          num="1"
        else
          num="2"
        fi
        for l in {1..3}
        do
          if (( l == 1 )) && [ $loci = "10L" ]
          then
            iter="75"
            sed -i "22 c nsample = 75000" "$basedir/A01.bpp.ctl"
            sed -i "20 c burnin = 7500" "$basedir/A01.bpp.ctl"
          elif (( l == 2 )) && [ $loci = "10L" ]
          then
            iter="200"
            sed -i "22 c nsample = 200000" "$basedir/A01.bpp.ctl"
            sed -i "20 c burnin = 20000" "$basedir/A01.bpp.ctl"
          elif (( l == 3 )) && [ $loci = "10L" ]
          then
            iter="500"
            sed -i "22 c nsample = 500000" "$basedir/A01.bpp.ctl"
            sed -i "20 c burnin = 50000" "$basedir/A01.bpp.ctl"
          elif (( l == 1 ))
          then
            iter="30"
            sed -i "22 c nsample = 30000" "$basedir/A01.bpp.ctl"
            sed -i "20 c burnin = 3000" "$basedir/A01.bpp.ctl"
          elif (( l == 2 ))
          then
            iter="80"
            sed -i "22 c nsample = 80000" "$basedir/A01.bpp.ctl"
            sed -i "20 c burnin = 8000" "$basedir/A01.bpp.ctl"
          else
            iter="200"
            sed -i "22 c nsample = 200000" "$basedir/A01.bpp.ctl"
            sed -i "20 c burnin = 20000" "$basedir/A01.bpp.ctl"
          fi
          bppctlfiledest="$basedir/$method/$loci/$rate/$num/$iter"
          sed -i "1 c seed = $RANDOM" "$basedir/A01.bpp.ctl"
          sed -i "2 c seqfile = $bppctlfiledest/$loci-$rate-$num-phased.phy" "$basedir/A01.bpp.ctl"
          sed -i "3 c Imapfile = $bppctlfiledest/Imap.txt" "$basedir/A01.bpp.ctl"
          sed -i "4 c outfile = $bppctlfiledest/$loci-$rate-$num-$iter-out.txt" "$basedir/A01.bpp.ctl"
          sed -i "5 c mcmcfile = $bppctlfiledest/$loci-$rate-$num-$iter-mcmc.txt" "$basedir/A01.bpp.ctl"
          cp "$basedir/A01.bpp.ctl" "$bppctlfiledest/A01.bpp.ctl"
          sed -i "10 c $bppdir/bpp.exe --cfile $bppctlfiledest/A01.bpp.ctl" run.txt
          sed -i "9 c echo \$SECONDS > $bppctlfiledest/timeelapsed.txt" run.txt
          sed -i "11 c echo \$SECONDS >> $bppctlfiledest/timeelapsed.txt" run.txt
          cp "$basedir/run.txt" "$bppctlfiledest/run.txt"
          qsub "$bppctlfiledest/run.txt"
        done
      done
    done
  done
rm run.txt
rm A01.bpp.ctl
else
  echo "####Program for estimating the phase resolution of diploid heterozygous data####"
  echo '!!!Make sure to change "bppdir=" and "basedir=" in file to the correct locations before running!!!'
  echo '###Options are "diploidoption" "PHASE" "fulldata" and "random"###'
  echo "##diploidoption: bpp's built-in method for phase resolution##"
  echo "##PHASE: a population genetics method for resolving phase by Matthew Stephens##"
  echo "##fulldata: for estimating the posterior when the full diploid data is available, useful for comparing methods##"
fi
