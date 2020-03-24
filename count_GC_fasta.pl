$reads = $ARGV[0];
$length = $ARGV[1];

$current_header = "";
$current_reads = "";
my %db;

my $gc = 0;
my $all = 0;

open (FILE, $reads);
while($buff = <FILE>){
	chomp $buff;
	if(substr($buff,0,1) eq ">"){
		$header = $buff;	
		
		#if(length($current_reads) >= $length){
		#	print $current_header . "\n";
		#	print $current_reads . "\n";
		#}	
		
		$gc += $current_reads =~ tr/C|G|c|g//;	
		$all += length(trim($current_reads));

		$current_header = $header;
		$current_reads = "";

	}else{
		$read = $buff;	
		$current_reads .= $read;
	}
}

#if(length($current_reads) >= $length){
#	print $current_header . "\n";
#	print $current_reads . "\n";
#}
#

$gc += $current_reads =~ tr/C|G|c|g//;
$all += length(trim($current_reads));

$perc = $gc / $all;

print $perc . "\n";


sub trim($)
{
	my $string = shift;
	$string =~ s/^\s+//;
	$string =~ s/\s+$//;
	return $string;
}

