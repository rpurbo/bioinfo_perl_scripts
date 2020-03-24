$reads = $ARGV[0];
$out = $ARGV[1];

open(OUT, ">" . $out);
open (FILE, $reads);
while($buff = <FILE>){
	chomp $buff;
	if(substr($buff,0,1) eq "@"){
		#$header = substr($buff,1,length($buff)-1);	
		$read = <FILE>;
		chomp $read;
		#@M00180:14:000000000-A0JW0:1:1:15434:1405/1
		$buff =~ /@(.+):(.+):(.+):(.+):(.+):(.+):(.+)\s+(.+):.+:.+:.+$/g;
		#$buff =~ /@(.+):(.+):(.+):(.+):(.+):(.+):(.+)\s(.):(.):(.):(.)$/g;
		$mach = $1 . $2 . $3;	
		$lane = $4;
		$tile = $5;
		$x = $6;
		$y = $7;
		$pair = $8;
			
                $ns = 0;
                $ns = $read =~ tr/N/N/;

                #if ($ns < 10 && length($read) > 30){
			print OUT ">" . $mach . ":" . $lane . ":" . $tile . ":" . $x . ":" . $y . "#0/" . $pair . "\n";
			print OUT $read . "\n";
		#}
	}

	if(substr($buff,0,1) eq "+"){
                $qual = <FILE>;
		#chomp $qual;
		#print "+\n";
		#print $qual . "\n";
        }
}
close (FILE);
close(OUT);


sub trim($)
{
	my $string = shift;
	$string =~ s/^\s+//;
	$string =~ s/\s+$//;
	return $string;
}

