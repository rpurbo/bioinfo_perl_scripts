$reads = $ARGV[0];

$current_header = "";
$current_reads = "";

open (FILE, $reads);
while($buff = <FILE>){
	chomp $buff;
	if(substr($buff,0,1) eq ">"){
		$header = substr($buff,1);	
		if($current_reads ne ""){	
			print "@" . $current_header . "\n";
			print $current_reads . "\n";
			print "+\n";
			$qual = "I" x (length($current_reads) );
                	print $qual . "\n";

		}
		$current_header = $header;
		$current_reads = "";

	}else{
		$read = $buff;	
		$current_reads .= trim($read);
	}
}
close (FILE);



sub trim($)
{
	my $string = shift;
	$string =~ s/^\s+//;
	$string =~ s/\s+$//;
	return $string;
}

