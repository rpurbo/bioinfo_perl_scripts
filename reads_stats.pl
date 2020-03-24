$reads = $ARGV[0];

my %reads_cnt;
my %buffs;

my $reads_cnt = 0;
my $bases = 0;
my $filtered = 0;

open (FILE, $reads);
while($buff = <FILE>){
	if(substr($buff,0,1) eq "@"){
		$header = $buff;	
		$buff = <FILE>;
		$read = $buff;
		$buff = <FILE>;
		$buff = <FILE>;
                $qual = $buff;
		
		$allb = $header . $read . "+\n" . $qual;	
		$reads_cnt{trim($read)}++;
		$buffs{trim($read)} = $allb;

		$reads_cnt++;
		$bases += length(trim($read)); 
	}
}
close (FILE);



print STDERR "reads: " . $reads_cnt . "\n";
print STDERR "bases: " . $bases . "\n";


sub trim($)
{
	my $string = shift;
	$string =~ s/^\s+//;
	$string =~ s/\s+$//;
	return $string;
}

