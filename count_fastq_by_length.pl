$reads = $ARGV[0];
$len = $ARGV[1];

open (FILE, $reads);
while($buff = <FILE>){
	if(substr($buff,0,1) eq "@"){
		$header = $buff;	
		$buff = <FILE>;
		$read = $buff;
		$buff = <FILE>;
		$buff = <FILE>;
                $qual = $buff;

		if(length($read) >= $len){
			$cnt++;
			$bases += length($read);
		}
		
		$all++;
	}
}
close (FILE);

print STDERR "#Reads longer than " . $len . " : " . $cnt . "\n";
print STDERR "#Bases in reads longer than " . $len . " : " . $bases . "\n";
print STDERR "Perceentage : " . (($cnt / $all) * 100) . "%\n";


sub trim($)
{
	my $string = shift;
	$string =~ s/^\s+//;
	$string =~ s/\s+$//;
	return $string;
}

