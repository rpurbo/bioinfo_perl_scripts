$reads = $ARGV[0];

$pad = "N" x 100;

$current_header = "";
$current_reads = "";

open (FILE, $reads);
while($buff = <FILE>){
	if(substr($buff,0,1) eq ">"){
		$header = $buff;	
		chomp $header;		

		if($current_reads ne ""){
			$current_reads .= $pad;	
		}

		$current_header = $header;		

	}else{
		$read = $buff;	
		chomp $read;
		$current_reads .= trim($read);
	}
}
close (FILE);


print $current_header . "\n";
print $current_reads . "\n";


sub trim($)
{
	my $string = shift;
	$string =~ s/^\s+//;
	$string =~ s/\s+$//;
	return $string;
}

