basedir="$PWD"
scriptpath="$basedir/scripts/PHASE"
rateslist='low high'

sed -i "5 c #\$ -e $basedir/error/PHASED/phasing" "$scriptpath/phasing.sh"
sed -i "6 c #\$ -o $basedir/output/PHASED/phasing" "$scriptpath/phasing.sh"

for nloci in {10,50,250}
do
  loci="$nloci"L
  sed -i "13 c for i in {1..$nloci}" "$scriptpath/phasing.sh"
  sed -i "26 c for j in {1..$nloci}" "$scriptpath/phasing.sh"
  for rate in $rateslist
  do
    for num in {1..2}
    do
      if (( $nloci == 10 ))
      then
        for iter in {75,200,500}
        do
          seqname=$loci-$rate-$num.phy
          sed -i "8 c cd $basedir/PHASED/$loci/$rate/$num/$iter" "$scriptpath/phasing.sh"
          sed -i "11 c \"$scriptpath/./bpp_to_fasta.py\" \"$seqname\"" "$scriptpath/phasing.sh"
          sed -i "15 c \ \ $scriptpath/./seqphase1.pl -1 $loci-$rate-$num--locus\$i.fas -p phase\$i" "$scriptpath/phasing.sh"
          sed -i "16 c \ \ $scriptpath/./PHASE -q0 -p0 phase\$i.inp phase\$i.out" "$scriptpath/phasing.sh"
          sed -i "17 c \ \ $scriptpath/./seqphase2.pl -c phase\$i.const -i phase\$i.out -o locus\$i.fas" "$scriptpath/phasing.sh"
          sed -i "19 c \ \ rm $loci-$rate-$num--locus\$i.fas" "$scriptpath/phasing.sh"
          sed -i "24 c touch $loci-$rate-$num-phased.phy" "$scriptpath/phasing.sh"
          sed -i "29 c \ \ cat locus\$j.fas.phylip <(echo) >> $loci-$rate-$num-phased.phy" "$scriptpath/phasing.sh"
          sed -i "28 c \ \ $scriptpath/./fasta_to_phylip.py locus\$j.fas" "$scriptpath/phasing.sh"
          qsub "$scriptpath/phasing.sh"
        done
      else
        for iter in {30,80,200}
        do
          seqname=$loci-$rate-$num.phy
          sed -i "8 c cd $basedir/PHASED/$loci/$rate/$num/$iter" "$scriptpath/phasing.sh"
          sed -i "11 c \"$scriptpath/./bpp_to_fasta.py\" \"$seqname\"" "$scriptpath/phasing.sh"
          sed -i "15 c \ \ $scriptpath/./seqphase1.pl -1 $loci-$rate-$num--locus\$i.fas -p phase\$i" "$scriptpath/phasing.sh"
          sed -i "16 c \ \ $scriptpath/./PHASE -q0 -p0 phase\$i.inp phase\$i.out" "$scriptpath/phasing.sh"
          sed -i "17 c \ \ $scriptpath/./seqphase2.pl -c phase\$i.const -i phase\$i.out -o locus\$i.fas" "$scriptpath/phasing.sh"
          sed -i "19 c \ \ rm $loci-$rate-$num--locus\$i.fas" "$scriptpath/phasing.sh"
          sed -i "24 c touch $loci-$rate-$num-phased.phy" "$scriptpath/phasing.sh"
          sed -i "29 c \ \ cat locus\$j.fas.phylip <(echo) >> $loci-$rate-$num-phased.phy" "$scriptpath/phasing.sh"
          sed -i "28 c \ \ $scriptpath/./fasta_to_phylip.py locus\$j.fas" "$scriptpath/phasing.sh"
          qsub "$scriptpath/phasing.sh"
          sleep 1
        done
      fi
    done
  done
done 
