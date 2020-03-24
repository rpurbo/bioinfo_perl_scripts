$reads = $ARGV[0];
$len = $ARGV[1];

open (FILE, $reads);
while($buff = <FILE>){
	if(substr($buff,0,1) eq "@"){
		$header = substr($buff,1,length($buff)-1);	
		$read = <FILE>;
	
		print "@" . $header;
		print substr($read, $len , (length($read) - (2*$len))) . "\n";

		
	}

	if(substr($buff,0,1) eq "+"){
		print "+\n";
                $read = <FILE>;
		print substr($read, $len , (length($read) - (2*$len))) . "\n";
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

