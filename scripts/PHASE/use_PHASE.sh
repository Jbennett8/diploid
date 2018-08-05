basedir="$PWD"
scriptpath="$basedir/scripts/PHASE"
rateslist='low high'

sed -i "5 c $basedir/error/PHASE/phasing" "$scriptpath/phasing.sh"
sed -i "6 c $basedir/output/PHASE/phasing" "$scriptpath/phasing.sh"

for nloci in {10,50,250}
do
  loci="$nloci"L
  sed -i "13 c for i in {1..$nloci}" "$scriptpath/phasing.sh"
  sed -i "26 c for j in {1..$nloci}" "$scriptpath/phasing.sh"
  for rate in $rateslist
  do
    for num in {1..2}
    do
      for iter in {15,40,100}
      do
        seqname=$loci-$rate-$num.phy
        sed -i "7 c #$ -wd $basedir/PHASED/$loci/$rate/$num/$iter" "$scriptpath/phasing.sh"
        sed -i "11 c \"$scriptpath/./bpp_to_fasta.py\" \"$seqname\"" "$scriptpath/phasing.sh"
        sed -i "15 c \ \ $scriptpath/./seqphase1.pl -1 $loci-$rate-$num--locus\$i.fas -p phase\$i" "$scriptpath/phasing.sh"
        sed -i "19 c \ \ rm $loci-$rate-$num--locus\$i.fas" "$scriptpath/phasing.sh"
        sed -i "24 c touch $loci-$rate-$num-phased.phy" "$scriptpath/phasing.sh"
        sed -i "29 c \ \ cat locus\$j.fas.phylip <(echo) >> $loci-$rate-$num-phased.phy" "$scriptpath/phasing.sh"
        sed -i "28 c \ \ $scriptpath/./fasta_to_phylip.py locus\$j.fas" "$scriptpath/phasing.sh"
        qsub "$scriptpath/phasing.sh"
      done
    done
  done
done 
