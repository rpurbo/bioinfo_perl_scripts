$reads = $ARGV[0];
$index = $ARGV[1];
$output = $ARGV[2];

$reads = "zcat " . $reads . "|";


open (FILE, $reads);
open(OUT, ">" . $output);
while($buff = <FILE>){
	chomp $buff;
	if(substr($buff,0,1) eq "@"){
		$buff =~ /@(.+)\s(.+):(.+):(.+):(.+)/g;
		$idx = $5;		

		#print OUT ">" . $mach . ":" . $lane . ":" . $tile . ":" . $x . ":" . $y . "#0/" . $pair . "\n";
		#print OUT $read . "\n";
		
		#print $buff . "\n";
		#print $idx . "\n";	
	
		$seq = <FILE>;
		$plus = <FILE>;
		$qual = <FILE>;

		if($idx eq $index){
			print $buff . "\n";
			print $seq ;
			print "+\n";
			print $qual;
		} 
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

