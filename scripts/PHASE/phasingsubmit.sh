#$ -S /bin/bash
#$ -l h_rt=80:0:0
#$ -l h_vmem=8G
#$ -l tmem=8G
#$ -e /SAN/yanglab/abacus/jeremy/git/diploid/newscript/error/PHASED/phasing
#$ -o /SAN/yanglab/abacus/jeremy/git/diploid/newscript/output/PHASED/phasing
#$ -wd /SAN/yanglab/abacus/jeremy/git/diploid/newscript/B/PHASED/250L/low
#$ -N phasing.B.250L.low.100
phasescripts=../../../../../scripts/PHASE
for i in {91..100}
do
  cd $i
  seqfile=B-PHASED-250L-low-$i
  touch $seqfile-phased.phy
  $phasescripts/./bpp_to_fasta.py $seqfile.phy
  for j in {1..250}
  do
    $phasescripts/./seqphase1.pl -1 $seqfile--locus$j.fas -p phase$j
    $phasescripts/./PHASE -q0 -p0 phase$j.inp phase$j.out
    $phasescripts/./seqphase2.pl -c phase$j.const -i phase$j.out -o locus$j
    rm $seqfile--locus$j.fas
    rm phase$j.phylip phase$j.inp phase$j.out phase$j.const phase$j.out phase$j.out_* phase$j.known
    $phasescripts/./fasta_to_phylip.py locus$j
    cat locus$j.phylip <(echo) >> $seqfile-phased.phy
    rm locus$j locus$j.phylip locus$j.known
  done
  cd ..
done


