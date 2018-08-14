jobloc=scripts/PHASE/phasingsubmit.sh
current="$PWD"

for tree in {"U","B"}
do
  for loci in {10,50,250}
  do
    for rate in {high,low}
    do
      for replicate in {10,20,30,40,50,60,70,80,90,100}
      do
        sed -i "7 c #\$ -wd $current/$tree/PHASED/${loci}L/$rate" "$jobloc"
        sed -i "8 c #\$ -N phasing.$tree.${loci}L.$rate.$replicate" "$jobloc"
        start=$(( $replicate - 9 ))
        sed -i "10 c for i in {$start..$replicate}" "$jobloc"
        sed -i "13 c \ \ seqfile=$tree-PHASED-${loci}L-$rate-\$i" "$jobloc"
        sed -i "16 c \ \ for j in {1..$loci}" "$jobloc"
        qsub "$jobloc"
      done
    done
  done
done
