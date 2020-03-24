$reads = $ARGV[0];

open (FILE, $reads);
while($buff = <FILE>){
	if(substr($buff,0,1) eq "@"){
		#$header = substr($buff,1,length($buff)-1);	
		$header = $buff;
		$read = <FILE>;
		$plus = <FILE>;
		$qual = <FILE>;
		$all = $header . $read . $plus . $qual;

		@tok = split(/\s/,$header);
		@tok2 = split(/:/,$tok[1]);
		$flag = $tok2[1];
		
		if($flag ne "Y"){
			print $all;
		}
		
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

