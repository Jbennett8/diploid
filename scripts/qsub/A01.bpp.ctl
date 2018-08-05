seed = -1
seqfile = /SAN/yanglab/abacus/jeremy/testruns/random/250L/high/2/100/250L-high-2-phased.phy
Imapfile = /SAN/yanglab/abacus/jeremy/testruns/random/250L/high/2/100/Imap.txt
outfile = /SAN/yanglab/abacus/jeremy/testruns/random/250L/high/2/100/250L-high-2-100-out.txt
mcmcfile = /SAN/yanglab/abacus/jeremy/testruns/random/250L/high/2/100/250L-high-2-100-mcmc.txt
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
thetaprior = 3 0.002 e
tauprior = 3 0.08
finetune = 1: .01 .01 .01 .01 .01 .01 .01
print = 1 0 0 0
burnin = 10000
sampfreq = 2
nsample = 100000
