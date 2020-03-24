$reads = $ARGV[0];

$avg = 400;

$current_header = "";
$current_reads = "";
my %db;

open (FILE, $reads);
while($buff = <FILE>){
	chomp $buff;
	if(substr($buff,0,1) eq ">"){
		$header = $buff;	
		
		if($current_reads ne ""){	
			$current_header =~ m/>(.+)(\s+)length=(\d+)(\s+)numreads=(.+)/g;
                	$len = $3;
                	$id = $1;
                	$cov = $5;
			$cov = ($cov * $avg) / $len;

                	#print $current_header . "\n";
                	print $id . "\t" . $cov . "\t" . $len . "\n";		
		}

		$current_header = $header;
		$current_reads = "";

	}else{
		$read = $buff;	
		$current_reads .= $read;
	}
}


$current_header =~ m/>(.+)(\s+)length=(\d+)(\s+)numreads=(.+)/g;
$len = $3;
$id = $1;
$cov = $5;
$cov = ($cov * $avg) / $len;

#print $current_header . "\n";
print $id . "\t" . $cov . "\t" . $len . "\n";




sub trim($)
{
	my $string = shift;
	$string =~ s/^\s+//;
	$string =~ s/\s+$//;
	return $string;
}

