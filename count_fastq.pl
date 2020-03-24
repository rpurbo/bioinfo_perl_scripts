$reads = $ARGV[0];

my $reads_cnt = 0;
my $bases = 0;
my $filtered = 0;

$min = 10000000000;
$max = 0;

open (FILE, $reads);
while($buff = <FILE>){
	if(substr($buff,0,1) eq "@"){
		$header = $buff;	
		$buff = <FILE>;
		$read = $buff;
		$buff = <FILE>;
		$buff = <FILE>;
                $qual = $buff;
		
		$reads_cnt++;
		$bases += length(trim($read)); 

		if(length(trim($read)) < $min && length(trim($read)) != 0){
			$min = length(trim($read));
		}
		
		if(length(trim($read)) > $max){
			$max = length(trim($read));
		}
	}
}
close (FILE);



print STDERR "reads: " . $reads_cnt . "\n";
print STDERR "bases: " . $bases . "\n";
print STDERR "avg length: " . ($bases/$reads_cnt) . "\n";
print STDERR "min: " . $min . "\n";
print STDERR "max: " . $max . "\n";

sub trim($)
{
	my $string = shift;
	$string =~ s/^\s+//;
	$string =~ s/\s+$//;
	return $string;
}

