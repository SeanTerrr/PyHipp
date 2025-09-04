#!/bin/bash

print_hms() {
  local secs=$1
  local total=$(cut -d. -f1 <<< "$secs")

  local hours=$(( total / 3600 ))
  local minutes=$(( (total % 3600) / 60 ))
  local seconds=$(( total % 60 ))

  printf "%s seconds = %02dh %02dm %02ds\n" "$secs" "$hours" "$minutes" "$seconds"
}

echo "Number of hkl files"
find . -name "*.hkl" | grep -v -e spiketrain -e mountains | wc -l

echo "Number of mda files"
find mountains -name "firings.mda" | wc -l

echo
echo "#==========================================================="

echo "Start Times"
for f in rpl*.out; do
  echo "==> $f <=="
  head -n 1 "$f"
  echo
done

echo "End Times"
for f in rpl*.out; do
  echo "==> $f <=="
  tail -n 2 "$f"
  echo
done
echo "#==========================================================="

secsParallel=$(tail -n 1 rplpl*.out | cut -d. -f1)
secsSplit=$(tail -n 1 rplsp*.out | cut -d. -f1)

secsTotal=$((secsParallel + secsSplit))

echo "Sum of two jobs"
print_hms "$secsTotal"
echo

actualTimeTakenSecs=$(( secsParallel > secsSplit ? secsParallel : secsSplit ))
echo "Actual time taken for both jobs to complete"
print_hms "$actualTimeTakenSecs"
echo

secsSaved=$((secsTotal-actualTimeTakenSecs))
echo "Time saved in parallelizing the jobs"
print_hms "$secsSaved"
echo

secs110Channels=$(((secsSplit / 8) * 110))
echo "Extrapolated time taken to process all 110 channels"
print_hms "$secs110Channels"
echo
