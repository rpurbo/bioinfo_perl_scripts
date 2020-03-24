$qseq = $ARGV[0];

open (FILE, $qseq);
while($buff = <FILE>){
	chomp $buff;
	@tok = split(/\t/, $buff);
	$header = "@" . $tok[0] . "_" . $tok[1] . ":" . $tok[2] . ":" .$tok[3] . ":" . $tok[4] . ":" . $tok[5] . "#" . $tok[6] . "/" . $tok[7];
	$reads = $tok[8];
	$reads =~ s/\./N/g;
	$qual = $tok[9];	
	$pass = $tok[10];

	if($pass == 0){
		print $header . "\n";	
		print $reads  . "\n";
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

