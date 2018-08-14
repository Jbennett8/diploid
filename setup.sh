#$ -S /bin/bash
#$ -l h_rt=10:0:0
#$ -l h_vmem=2G
#$ -l tmem=2G
#$ -cwd
#$ -N Createdata

#For use in diploid comparison study
#Creates the directories specified by options given and populates them with simulated MCcoal data
#Options: ./setup.sh -l <locilist>
#Example to create datasets with 50,100,200 loci: ./setup.sh -l 50,100,200

MCcoalctl=scripts/setup/MCcoal.ctl
MCcoalexe=scripts/setup/MCcoal.exe


if [ "$1" = "-l" ]
then
  locistr=$2
else
  locistr="10,50,250"
  echo "No loci option specified, default assumed"
fi

if [ "$3" = "-m" ]
then
  methodstr=$4
else
  methodstr="fulldata,diploidoption,PHASED,random"
  echo "No method option specified, default assumed"
fi

echo "Chose methods $methodstr to investigate"
echo "Chose $locistr loci to generate"

#Make directories
echo "Creating directories based on options selected"
locistr2=$(echo $locistr | sed 's/\([0-9]\+\)/\1L/g')
eval mkdir -p {U,B}/{$methodstr}/{$locistr2}/{high,low}/{1..100}



#Populate with MCcoal data
methodlist=$(echo $methodstr | sed 's/,/ /g')
locilist=$(echo $locistr | sed 's/,/ /g')
ratelist="low high"

Ulow='(((((((A #0.001, B #0.001):0.001 #0.001, C #0.001):0.0012 #0.001, D #0.001):0.002 #0.001, E #0.001):0.0025 #0.001, F #0.001):0.003 #0.001, G #0.001):0.0032 #0.001, H #0.001):0.004 #0.001;'
Uhigh='(((((((A #0.01, B #0.01):0.01 #0.01, C #0.01):0.012 #0.01, D #0.01):0.02 #0.01, E #0.01):0.025 #0.01, F #0.01):0.03 #0.01, G #0.01):0.032 #0.01, H #0.01):0.04 #0.01;'
Blow='(((A #0.001, B #0.001):0.001 #0.001, (C #0.001, D #0.001):0.0018 #0.001):0.002 #0.001, ((E #0.001, F #0.001):0.001 #0.001, (G #0.001, H #0.001):0.0018 #0.001):0.002 #0.001):0.003 #0.001;'
Bhigh='(((A #0.01, B #0.01):0.01 #0.01, (C #0.01, D #0.01):0.018 #0.01):0.02 #0.01, ((E #0.01, F #0.01):0.01 #0.01, (G #0.01, H #0.01):0.018 #0.01):0.02 #0.01):0.03 #0.01;'

for tree in {"U","B"}
do
  for method in $methodlist
  do
    if [ "$method" = "fulldata" ]
    then
      sed -i '5 c 2 2 2 2 2 2 2 2' $MCcoalctl
      sed -i '8 c diploid = 0 0 0 0 0 0 0 0' $MCcoalctl
    else
      sed -i '5 c 1 1 1 1 1 1 1 1' $MCcoalctl
      sed -i '8 c diploid = 1 1 1 1 1 1 1 1' $MCcoalctl
    fi
    for loci in $locilist
    do
      sed -i "9 c loci&length=$loci 500" $MCcoalctl
      for rate in $ratelist
      do
        if [ "$tree" = "U" ] && [ "$rate" = "low" ]
        then
          sed -i "6 c $Ulow" $MCcoalctl
        elif [ "$tree" = "U" ] && [ "$rate" = "high" ]
        then
          sed -i "6 c $Uhigh" $MCcoalctl
        elif [ "$tree" = "B" ] && [ "$rate" = "low" ]
        then
          sed -i "6 c $Blow" $MCcoalctl
        else
          sed -i "6 c $Bhigh" $MCcoalctl
        fi
        for replicate in {1..100}
        do
          seqfile="$tree-$method-${loci}L-$rate-$replicate.phy"
          sed -i "1 c seed = $RANDOM" $MCcoalctl
          sed -i "2 c seqfile = $seqfile 0" $MCcoalctl
          cp $MCcoalctl "$tree/$method/${loci}L/$rate/$replicate/MCcoal.ctl"
          $MCcoalexe $MCcoalctl
          mv "$seqfile" "$tree/$method/${loci}L/$rate/$replicate/$seqfile"
        done
      done
    done
  done
done
