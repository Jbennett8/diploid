#$ -S /bin/bash
#$ -l h_rt=10:0:0
#$ -l h_vmem=2G
#$ -l tmem=2G
#$ -e /SAN/yanglab/abacus/jeremy/git/diploid/error/PHASED/phasing
#$ -o /SAN/yanglab/abacus/jeremy/git/diploid/output/PHASED/phasing
#$ -cwd 
#$ -N phasing.250L.high.2.200
cd /SAN/yanglab/abacus/jeremy/git/diploid/PHASED/250L/high/2/200

"/SAN/yanglab/abacus/jeremy/git/diploid/scripts/PHASE/./bpp_to_fasta.py" "250L-high-2.phy"

for i in {1..250}
do
  /SAN/yanglab/abacus/jeremy/git/diploid/scripts/PHASE/./seqphase1.pl -1 250L-high-2--locus$i.fas -p phase$i
  /SAN/yanglab/abacus/jeremy/git/diploid/scripts/PHASE/./PHASE -q0 -p0 phase$i.inp phase$i.out
  /SAN/yanglab/abacus/jeremy/git/diploid/scripts/PHASE/./seqphase2.pl -c phase$i.const -i phase$i.out -o locus$i.fas
  rm phase$i.const phase$i.known phase$i.out_*
  rm 250L-high-2--locus$i.fas
  rm phase$i.inp phase$i.out
done


touch 250L-high-2-phased.phy

for j in {1..250}
do
  /SAN/yanglab/abacus/jeremy/git/diploid/scripts/PHASE/./fasta_to_phylip.py locus$j.fas
  cat locus$j.fas.phylip <(echo) >> 250L-high-2-phased.phy
  rm locus$j.fas
  rm locus$j.fas.phylip
done
