#!/bin/bash
RMAFILE=$1
OUTPUT=$RMAFILE".summary"

echo $RMAFILE
echo $OUTPUT

/home/rikky/rapsearch2rma/xvfb-run -a /home/rikky/rapsearch2rma/megan/MEGAN +g -E<<END
open file='$RMAFILE' readonly=true;
save file='$OUTPUT' summary=true;

quit;
END
