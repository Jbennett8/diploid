#!/bin/bash
qsub -S /bin/bash -l h_vmem=1G -l tmem=1G -l h_rt=1:0:0 -cwd createdata.sh
