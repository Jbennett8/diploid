seed = 330
seqfile = /SAN/yanglab/abacus/jeremy/git/diploid/newscript/B/PHASED/250L/high/100/B-PHASED-250L-high-100-phased.phy
Imapfile = /SAN/yanglab/abacus/jeremy/git/diploid/newscript/scripts/qsub/ImapPHASE.txt
outfile = /SAN/yanglab/abacus/jeremy/git/diploid/newscript/B/PHASED/250L/high/100/out.txt
mcmcfile = /SAN/yanglab/abacus/jeremy/git/diploid/newscript/B/PHASED/250L/high/100/mcmc.txt
speciesdelimitation = 0
speciestree = 1 0 0 0
speciesmodelprior = 1
species&tree = 8 A B C D E F G H
2 2 2 2 2 2 2 2
(((((((A, B), C), D), E), F), G), H);
diploid = 0 0 0 0 0 0 0 0
usedata = 1
nloci = 250
cleandata = 0
thetaprior = 3 0.02 e
tauprior = 3 0.08
finetune = 1: .01 .01 .01 .01 .01 .01 .01
print = 1 0 0 0
burnin = 20000
sampfreq = 2
nsample = 200000
