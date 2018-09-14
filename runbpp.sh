bppprogram="/SAN/yanglab/abacus/jeremy/bpp4.0/bpp.exe" #modify this to match the location of the bpp program on host pc
basedir="$PWD"

scripts=scripts/qsub
bppctl=$scripts/A01.bpp.ctl
submit=$scripts/run.txt
altsubmit=$scripts/runonce.txt

#Default argument values
methodlist="fulldata diploidoption PHASED random"
locilist="10 50 250"
fast="0"

#Change values based on arguments selected
if [ "$#" = "0" ]
then
  echo "No options specified, default loci and methods assumed"
else
  array=( "$@" )
  counter=0
  while [ $counter -lt ${#array[@]} ]
  do
    argument=${array[$counter]}
    if [ "$i" = "-l" ]
    then
      (( counter++ ))
      locistr=${array[$counter]}
      locilist=$(echo $locistr | sed 's/,/ /g')
      echo "Loci configuration accepted"
    elif [ "$argument" = "-m" ]
    then
      (( counter++ ))
      methodstr=${array[$counter]}
      methodlist=$(echo $methodstr | sed 's/,/ /g')
      echo "Methods option accepted"
    elif [ "$argument" = "--fast" ]
    then
      echo "faster analyses: 250L analyses will be done in batches of one"
      fast="1"
    else
      echo "Options accepted: -l <locilist> -m <methodlist> --fast"
      exit 1
    fi
    (( counter++ ))
  done
fi

echo "methods: $methodlist"
echo "loci: $locilist"

for tree in {"U","B"}
do
  for method in $methodlist
  do
    sed -i "6 c #\$ -o $basedir/output/$method" $submit
    sed -i "7 c #\$ -e $basedir/error/$method" $submit
    sed -i "6 c #\$ -o $basedir/output/$method" $altsubmit
    sed -i "7 c #\$ -e $basedir/error/$method" $altsubmit
    if [ "$method" = "fulldata" ]
    then
      sed -i "10 c 2 2 2 2 2 2 2 2" $bppctl
      sed -i "12 c diploid = 0 0 0 0 0 0 0 0" $bppctl
    elif [ "$method" = "diploidoption" ]
    then
      sed -i "10 c 1 1 1 1 1 1 1 1" $bppctl
      sed -i "12 c diploid = 1 1 1 1 1 1 1 1" $bppctl
    elif [ "$method" = "PHASED" ]
    then
      sed -i "10 c 2 2 2 2 2 2 2 2" $bppctl
      sed -i "12 c diploid = 0 0 0 0 0 0 0 0" $bppctl
    else
      sed -i "10 c 1 1 1 1 1 1 1 1" $bppctl
      sed -i "12 c diploid = 0 0 0 0 0 0 0 0" $bppctl
    fi
    for loci in $locilist
    do
      sed -i "14 c nloci = $loci" $bppctl
      for rate in {"low","high"}
      do
        if [ "$rate" = "low" ]
        then
          sed -i "17 c tauprior = 3 0.008" $bppctl
          sed -i "16 c thetaprior = 3 0.002 e" $bppctl
        else
          sed -i "17 c tauprior = 3 0.08" $bppctl
          sed -i "16 c thetaprior = 3 0.02 e" $bppctl
        fi
        for repl in {1..100}
        do
          sed -i "1 c seed = $RANDOM" $bppctl
          if [ "$method" = "PHASED" ] || [ "$method" = "random" ]
          then
            sed -i "2 c seqfile = $basedir/$tree/$method/${loci}L/$rate/$repl/$tree-$method-${loci}L-$rate-$repl-phased.phy" $bppctl
          else
            sed -i "2 c seqfile = $basedir/$tree/$method/${loci}L/$rate/$repl/$tree-$method-${loci}L-$rate-$repl.phy" $bppctl
          fi
          if [ "$method" = "PHASED" ]
          then
            sed -i "3 c Imapfile = $basedir/$scripts/ImapPHASE.txt" $bppctl
          else
            sed -i "3 c Imapfile = $basedir/$scripts/Imap.txt" $bppctl
          fi
          sed -i "4 c outfile = $basedir/$tree/$method/${loci}L/$rate/$repl/out.txt" $bppctl
          sed -i "5 c mcmcfile = $basedir/$tree/$method/${loci}L/$rate/$repl/mcmc.txt" $bppctl
          cp "$scripts/A01.bpp.ctl" "$tree/$method/${loci}L/$rate/$repl/A01.bpp.ctl"
        done
        if [ "$loci" = "250" ] && [ "$fast" = "1" ]
        then
          for repl2 in {1..100}
          do
            wd="$basedir/$tree/$method/${loci}L/$rate/$repl2"
            sed -i "5 c #\$ -wd $wd" $altsubmit
            sed -i "8 c #\$ -N $tree.$method.$loci.$rate.$repl2" $altsubmit
            sed -i "10 c $bppprogram --cfile A01.bpp.ctl > log.txt" $altsubmit
            qsub $altsubmit
            sleep 2
          done
        else
          for qsub in {10,20,30,40,50,60,70,80,90,100}
          do
            wd="$basedir/$tree/$method/${loci}L/$rate"
            sed -i "5 c #\$ -wd $wd" $submit
            start=$(( $qsub - 9 ))
            sed -i "9 c for i in {$start..$qsub}" $submit
            sed -i "11 c \ \ $bppprogram --cfile $wd/\$i/A01.bpp.ctl > \$i/log.txt" $submit
            qsub $submit
            sleep 2
          done
        fi
      done
    done
  done
done
