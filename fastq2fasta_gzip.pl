$reads = $ARGV[0];
$reads = "zcat " . $reads . "|";

open (FILE, $reads);
while($buff = <FILE>){
	if(substr($buff,0,1) eq "@"){
		$header = substr($buff,1,length($buff)-1);	
		$read = <FILE>;
	
		print ">" . $header;
		print $read;

		
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

