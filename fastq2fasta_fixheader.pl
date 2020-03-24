$reads = $ARGV[0];

my %hs;

open (FILE, $reads);
while($buff = <FILE>){
	if(substr($buff,0,1) eq "@"){
		chomp $buff;
		$header = substr($buff,1,length($buff)-1);	
		$read = <FILE>;
		$plus = <FILE>;
		$qual = <FILE>;

		@tok = split(/\s/,$header);
		@tok2 = split(/\:/,$tok[1]);
		$pair = $tok2[0];	
		
		
		print ">" . $tok[0] . "/" . $pair . "\n";
		print $read;

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

