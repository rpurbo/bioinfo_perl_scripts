$reads = $ARGV[0];
$length = $ARGV[1];

$current_header = "";
$current_reads = "";
my %db;

open (FILE, $reads);
while($buff = <FILE>){
	chomp $buff;
	if(substr($buff,0,1) eq ">"){
		$header = $buff;	
		
		if(length($current_reads) >= $length && $current_reads ne ""){
			print $current_header . "\n";
			print $current_reads . "\n";
		}	

		$current_header = $header;
		$current_reads = "";

	}else{
		if($buff ne ""){
			$read = $buff;	
			$current_reads .= $read;
		}
	}
}

if(length($current_reads) >= $length && $current_reads ne "" ){
	print $current_header . "\n";
	print $current_reads . "\n";
}

sub trim($)
{
	my $string = shift;
	$string =~ s/^\s+//;
	$string =~ s/\s+$//;
	return $string;
}

