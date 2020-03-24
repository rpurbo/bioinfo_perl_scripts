#CONVERT FASTQ SANGER QUAL (33 to 73) to ILLUMINA 1.3 QUAL (64 to 104)

$reads = $ARGV[0];

open (FILE, $reads);
while($buff = <FILE>){
	chomp $buff;
	if(substr($buff,0,1) eq "@"){
		#$header = substr($buff,1,length($buff)-1);	
		$header = $buff;
		chomp $header;
		$read = <FILE>;
		chomp $read;
		$plus = <FILE>;
		chomp $plus;
		$qual = <FILE>;
		chomp $qual;
		
		$qualstr = "";	
		@tok = split(//,$qual);
		for $a (@tok){
			$val = ord($a);
			$val = $val - 33;
			$newval = $val + 64;
			if($newval > 104){
				$newval = 104;
			}

			$qualstr .= chr($newval);
		}

		#print ">" . $header;
		#print $read;

		print $header . "\n";
		print $read . "\n";
		print $plus . "\n";
		print $qualstr . "\n";	
	}

}
close (FILE);



sub trim($)
{
	my $string = shift;
	$string =~ s/^\s+//;
	$string =~ s/\s+$//;
	return $string;
}

