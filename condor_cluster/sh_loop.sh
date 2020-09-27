#!/bin/bash

for i in `seq 1 $1`; do
	echo -n $i " "
	sleep 1
done

echo ""
echo "End of Job"
