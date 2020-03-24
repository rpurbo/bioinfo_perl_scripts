$reads = $ARGV[0];

open (FILE, $reads);
while($buff = <FILE>){
	chomp $buff;
	if(substr($buff,0,1) eq "@"){
		#$header = substr($buff,1,length($buff)-1);	
		$read = <FILE>;
		chomp $read;
		#@M00180:14:000000000-A0JW0:1:1:15434:1405/1
		#$buff =~ /@(.+):(.+):(.+):(.+):(.+):(.+):(.+)\/(.+)/g;
		$buff =~ /@(.+):(.+):(.+):(.+):(.+):(.+):(.+)\s(.):(.):(.):(.)$/g;
		$mach = $1 . $2 . $3;	
		$lane = $4;
		$tile = $5;
		$x = $6;
		$y = $7;
		$pair = $8;

		print "@" . $mach . ":" . $lane . ":" . $tile . ":" . $x . ":" . $y . "#0/" . $pair . "\n";
		print $read . "\n";
		
	}

	if(substr($buff,0,1) eq "+"){
                $qual = <FILE>;
		chomp $qual;
		print "+\n";
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

