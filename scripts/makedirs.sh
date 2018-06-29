#!/bin/bash
#makes nested directories to hold the 2400 datasets
#groups datasets in groups of the 100 replicates

mkdir -p {A..B}/{10L,50L,250L}/{high,low}/{1,2}
