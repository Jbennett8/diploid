bppprogram="/SAN/yanglab/abacus/jeremy/bpp4.0/bpp.exe" #modify this to match the location of the bpp program on host pc
basedir="$PWD"

scripts=scripts/qsub
bppctl=$scripts/A01.bpp.ctl
submit=$scripts/run.txt

methodlist="fulldata diploidoption PHASED random"
locilist="10 50 250"

for tree in {"U","B"}
do
  for method in $methodlist
  do
    if [ "$method" = "fulldata" ]
    then
      sed -i "10 c 2 2 2 2 2 2 2 2" $bppctl
      sed -i "12 c diploid = 0 0 0 0 0 0 0 0" $bppctl
      sed -i "6 c #\$ -o $basedir/output/fulldata" $submit
      sed -i "7 c #\$ -e $basedir/error/fulldata" $submit
    elif [ "$method" = "diploidoption" ]
    then
      sed -i "10 c 1 1 1 1 1 1 1 1" $bppctl
      sed -i "12 c diploid = 1 1 1 1 1 1 1 1" $bppctl
      sed -i "6 c #\$ -o $basedir/output/diploidoption" $submit
      sed -i "7 c #\$ -e $basedir/error/diploidoption" $submit
    elif [ "$method" = "PHASED" ]
    then
      sed -i "10 c 2 2 2 2 2 2 2 2" $bppctl
      sed -i "12 c diploid = 0 0 0 0 0 0 0 0" $bppctl
      sed -i "6 c #\$ -o $basedir/output/PHASED" $submit
      sed -i "7 c #\$ -e $basedir/error/PHASED" $submit
    else
      sed -i "10 c 1 1 1 1 1 1 1 1" $bppctl
      sed -i "12 c diploid = 0 0 0 0 0 0 0 0" $bppctl
      sed -i "6 c #\$ -o $basedir/output/random" $submit
      sed -i "7 c #\$ -e $basedir/error/random" $submit
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
          cp "$scripts/A01.bpp.ctl" "$tree/$method/${loci}L/$rate/$repl/A01.bpp.ctl"
          fi
        done
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
      done
    done
  done
done
