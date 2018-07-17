seed = -1
seqfile = ../frogs.txt
Imapfile = ../frogs.Imap.txt
outfile = out.txt
mcmcfile = mcmc.txt
speciesdelimitation = 0 # fixed species delimitation
speciestree = 1 0 0 0 # estimate species tree
speciesmodelprior = 1 # 0:uniform LH; 1:uniform rooted trees; 2:uniformSLH 3:uniformSRooted
species&tree = 4 K C L H # number of species and list of species labels
9 7 14 2 # max number of sequences from each species at a loci
((K, C), (L, H)); # initial species phylogeny
diploid = 0 0 0 0 # 0: phased sequences; 1: diploid unphased sequences.
* checkpoint = 0 * 0: nothing; 1 : save; 2: read
usedata = 1 # 0: no data (prior); 1: seq like
nloci = 5 # number of data sets to read in seqfile
cleandata = 0 # remove sites with ambiguity data (1: yes, 0: no)
thetaprior = 3 0.002 e # invgamma(a,b) for theta parameters
tauprior = 3 0.004 # invgamma(a,b) for root tau
* heredity = 1 4 4 # (0: no variation, 1: estimate, 2: from file)
* locusrate = 0 2.0 # (0: no variation, 1: estimate, 2: from file)
finetune = 1: .01 .01 .01 .01 .01 .01 .01 .01 # auto (0 or 1): MCMC step lengths
print = 1 0 0 0 # print MCMC samples, locusrate, heredity scalars, gene trees
burnin = 8000 # burn-In
sampfreq = 2 # frequency of sampling (sample every second MCMC iteration)
nsample = 100000 # total number of samples to log