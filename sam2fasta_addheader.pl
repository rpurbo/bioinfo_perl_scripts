$reads = $ARGV[0];

my %hs;

open (FILE, $reads);
while($buff = <FILE>){
	if(substr($buff,0,1) ne "@"){
		chomp $buff;
		
		@tok = split(/\t/, $buff);
		$header = $tok[0];
		$seq = $tok[9];
				

		if($hs{$header} eq ""){
			$hs{$header}= 1;
		}
		
		if(length($seq) >= 30){
			print ">" . $header . "/" . $hs{$header} . "\n";
			print $seq . "\n";
		}

		$hs{$header}++;
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

