$reads = $ARGV[0];

$current_header = "";
$current_reads = "";
my %db;

my $gc = 0;
my $all = 0;

open (FILE, $reads);
while($buff = <FILE>){
	chomp $buff;
	if(substr($buff,0,1) eq "@"){
		$header = $buff;
		$read = <FILE>;
		$plus = <FILE>;
		$qual = <FILE>;	
		
		$gc += $read =~ tr/C|G|c|g//;	
		$all += length(trim($read));


	}
}

$gc += $read =~ tr/C|G|c|g//;
$all += length(trim($read));

$perc = $gc / $all;

print $perc . "\n";


sub trim($)
{
	my $string = shift;
	$string =~ s/^\s+//;
	$string =~ s/\s+$//;
	return $string;
}

