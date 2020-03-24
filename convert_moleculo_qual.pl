$reads = $ARGV[0];

open (FILE, $reads);
while($buff = <FILE>){
	$header = $buff;
	$seq = <FILE>;
	$buff = <FILE>;
	$qual = <FILE>;

	chomp $qual;
	$newqual = "";
	@tok = split(//,$qual);
	for $q (@tok){
		$val = ord($q) - 33;
		if($val > 40){
			$newqual .= "I";
		}else{
			$newqual .= $q;
		}			

	}

	print $header;
	print $seq ;
	print $buff;
	print $newqual . "\n";


}
close (FILE);
