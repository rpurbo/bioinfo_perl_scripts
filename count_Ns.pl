$reads = $ARGV[0];

$longest = 0;
$current_header = "";
$current_reads = "";
my %db;

my $n = 0;
my $all = 0;

open (FILE, $reads);
while($buff = <FILE>){
	chomp $buff;
	if(substr($buff,0,1) eq ">"){
		$header = $buff;	
		$now = 0;
		$now = $current_reads =~ tr/N|n//;	

		if($now > $longest){
			$longest = $now;
		}

		$n += $now;
		$all += length(trim($current_reads));

		$current_header = $header;
		$current_reads = "";

	}else{
		$read = $buff;	
		$current_reads .= $read;
	}
}

$now = 0;
$now = $current_reads =~ tr/n|N//;

if($now > $longest){
	$longest = $now;
}

$n += $now;

$all += length(trim($current_reads));

$perc = ($n / $all) * 100;

print "Ns: " . $n . "\n";
print "Longest N: " . $longest . "\n";
print "non-Ns: " . ($all - $n) . "\n"; 
print "length: " . $all . "\n";
print "N %: " . $perc . "\n";


sub trim($)
{
	my $string = shift;
	$string =~ s/^\s+//;
	$string =~ s/\s+$//;
	return $string;
}

