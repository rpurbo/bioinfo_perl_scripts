$reads = $ARGV[0];
$newheader = $ARGV[1];
$filler = 'N' x 1000;

$current_header = "";
$current_reads = "";
$count = 0;
open (FILE, $reads);
while($buff = <FILE>){
	chomp $buff;
	if(substr($buff,0,1) eq ">"){
		$header = $buff;	
		if($current_reads ne ""){
			$current_reads .= $filler	
		}

	}else{
		$read = $buff;	
		$current_reads .= trim($read);
	}
}

print ">" . $newheader . "\n";
print $current_reads . "\n";


sub trim($)
{
	my $string = shift;
	$string =~ s/^\s+//;
	$string =~ s/\s+$//;
	return $string;
}

