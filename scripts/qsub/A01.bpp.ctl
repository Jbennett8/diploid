seed = 29868
seqfile = /SAN/yanglab/abacus/jeremy/git/diploid/newscript/B/random/250L/high/100/B-random-250L-high-100-phased.phy
Imapfile = /SAN/yanglab/abacus/jeremy/git/diploid/newscript/scripts/qsub/Imap.txt
outfile = out.txt
mcmcfile = mcmc.txt
speciesdelimitation = 0
speciestree = 1 0 0 0
speciesmodelprior = 1
species&tree = 8 A B C D E F G H
1 1 1 1 1 1 1 1
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
