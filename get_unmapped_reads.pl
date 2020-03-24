$unmapped_reads = $ARGV[0];
$reads = $ARGV[1];

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
		

		@token = split(/\s/, $header);
		$id = trim($token[0]);
		$buffs{trim($id)} = $allb;
	}
}
close (FILE);

open (FILE, $unmapped_reads);
while($buff = <FILE>){
	$id = trim($buff);
	print $buffs{$id};
	$cnt++;
}
close(FILE);

print STDERR $cnt . "\n";


sub trim($)
{
	my $string = shift;
	$string =~ s/^\s+//;
	$string =~ s/\s+$//;
	return $string;
}

