$file = $ARGV[0];

$q30 = $file . ".hq";
$q20 = $file . ".mq";
$lq = $file . ".lq";

open(HQ, ">" . $q30);
open(MQ, ">" . $q20);
open(LQ, ">" . $lq);

open(FILE, $file);
while($buff = <FILE>){
	$head = $buff;
	$seq = <FILE>;
	$plus = <FILE>;
	$qual = <FILE>;

	$tot =0;
	$avg =0;
	for ($i=0;$i<length($qual);$i++){
		$val = ord(substr($qual,$i,1)) - 33;
		$tot += $val;
	}

	$avg = $tot / length($qual);

	if($avg >= 30){
		print HQ $head;
		print HQ $seq;
		print HQ "+\n";
		print HQ $qual; 
	}elsif($avg >= 20){
                print MQ $head;
                print MQ $seq;
                print MQ "+\n";
                print MQ $qual;
	}else{
                print LQ $head;
                print LQ $seq;
                print LQ "+\n";
                print LQ $qual;
	}

}
close(FILE);
close(HQ);
close(MQ);
close(LQ);

