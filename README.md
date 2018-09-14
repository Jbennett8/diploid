## Steps to replicate



| Scripts to execute                       | Intended result                                                                                                                                                               |
| --------------------------               | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **qsub setup.sh**                        | Create the directories for all phasing methods in the analysis, and populate with MCcoal data                                                                                 |  
| **run scripts/PHASE/phasingmodify.sh**   | Use the algorithm PHASE to resolve phase of all the datasets in the PHASED directory                                                                                          |
| **run scripts/random/randommodify.sh**   | Resolves phase randomly for all the datasets in the random directory                                                                                                          |
| **run runbpp.sh**                        | Submits all bpp jobs to the cluster in groups of 10 sequential analyses. Run with argument --fast to run 250 locus jobs individually to save time                             |
| **run scripts/resubmit/checkcomplete.py**| Produces a text file notfound.txt which lists all datasets that for any reason did not complete the analysis                                                                  |
| **run scripts/resubmit/fix.py**          | If there are files listed in notfound.txt, this will resubmit the correct jobs. If checkcomplete still finds uncompleted analyses after fix.py they must be manually submitted|

