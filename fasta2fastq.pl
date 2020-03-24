$reads = $ARGV[0];

open (FILE, $reads);
while($buff = <FILE>){
	if(substr($buff,0,1) eq ">"){
		$header = substr($buff,1,length($buff)-1);	
		$read = <FILE>;
	
		print "@" . $header;
		print $read;
		print "+\n";
		$qual = "I" x (length($read) - 1);
		print $qual . "\n";	
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

