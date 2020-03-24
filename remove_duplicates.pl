$reads = $ARGV[0];

my %reads_cnt;
my %buffs;

my $all = 0;
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

		$all++
	}
}
close (FILE);

for $read (keys %reads_cnt){
	print $buffs{$read};
	$filtered++;	
}


print STDERR "total: " . $all . "\n";
print STDERR "filtered " . $filtered . "\n";


sub trim($)
{
	my $string = shift;
	$string =~ s/^\s+//;
	$string =~ s/\s+$//;
	return $string;
}

