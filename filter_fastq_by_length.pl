$reads = $ARGV[0];
$length = $ARGV[1];

open (FILE, $reads);
while($buff = <FILE>){
	$header = $buff;
	$seq = <FILE>;
	$plus = <FILE>;
	$qual = <FILE>;

	if(length($seq) > $length){
		print $header;
		print $seq;
		print $plus;
		print $qual;
	}
}
close (FILE);
