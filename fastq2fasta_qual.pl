$reads = $ARGV[0];

open (FILE, $reads);
while($buff = <FILE>){
	if(substr($buff,0,1) eq "@"){
		chomp $buff;
		$header = substr($buff,1,length($buff)-1);	
		$read = <FILE>;
			

		$cnt = 0;
		$cnt = $read =~ tr/N/N/;

		if ($cnt < 5){
			print ">" . $header . "\n";
			print $read;
		}
		
	}

	if(substr($buff,0,1) eq "+"){
                $read = <FILE>;
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

