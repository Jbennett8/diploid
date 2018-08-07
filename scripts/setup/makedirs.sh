#!/bin/bash

if [ "$1" = "all" ]
then
  mkdir -p {fulldata,diploidoption,PHASED,random}/{50L,250L}/{high,low}/{1,2}/{30,80,200}
  mkdir -p {fulldata,diploidoption,PHASED,random}/10L/{high,low}/{1,2}/{75,200,500}
  mkdir -p {error,output}/{fulldata,diploidoption,PHASED,random}
  mkdir -p {error,output}/PHASED/phasing
elif [ "$1" = "PHASE" ]
then
  mkdir -p PHASED/{50L,250L}/{high,low}/{1,2}/{30,80,200}
  mkdir -p PHASED/10L/{high,low}/{1,2}/{75,200,500}
  mkdir -p {error,output}/PHASED/phasing
elif [ "$1" = "fulldata" ]
then
  mkdir -p fulldata/{50L,250L}/{high,low}/{1,2}/{30,80,200}
  mkdir -p fulldata/10L/{high,low}/{1,2}/{75,200,500}
  mkdir -p {error,output}/fulldata
elif [ "$1" = "diploidoption" ]
then
  mkdir -p diploidoption/{50L,250L}/{high,low}/{1,2}/{30,80,200}
  mkdir -p diploidoption/10L/{high,low}/{1,2}/{75,200,500}
  mkdir -p {error,output}/diploidoption
elif [ "$1" = "random" ]
then
  mkdir -p random/{50L,250L}/{high,low}/{1,2}/{30,80,200}
  mkdir -p random/10L/{high,low}/{1,2}/{75,200,500}
  mkdir -p {error,output}/random
fi  

