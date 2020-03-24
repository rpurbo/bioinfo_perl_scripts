$reads = $ARGV[0];
$length = $ARGV[1];
$bases = 0;
$current_header = "";
$current_reads = "";
my %db;
$all = 0;
$count = 0;
open (FILE, $reads);
while($buff = <FILE>){
	chomp $buff;
	if(substr($buff,0,1) eq ">"){
		$header = $buff;	
		
		if(length($current_reads) >= $length){
			#print $current_header . "\n";
			#print $current_reads . "\n";
			$count++;
			$bases += length($current_reads);
			#$all++;
		}	

		$current_header = $header;
		$current_reads = "";
		$all++;
	}else{
		$read = $buff;	
		$current_reads .= $read;
	}
}

$all++;
if(length($current_reads) >= $length){
	#print $current_header . "\n";
	#print $current_reads . "\n";
	$count++;
	$bases += length($current_reads);
	#$all++;
}

$perc = ($count / $all) * 100;
print "#contigs longer than " . $length . ":\t" . $count . "\n";
print "#bases longer than " . $length . ":\t" . $bases . "\n";
print "total: " . $all . "\n";
print "%: " . $perc . "\n";

sub trim($)
{
	my $string = shift;
	$string =~ s/^\s+//;
	$string =~ s/\s+$//;
	return $string;
}

