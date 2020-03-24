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
		
		#>15449456 length 400 cvg_5.0_tip_0
		$current_header =~ m/>(.+)\slength\s(\d+)\scvg_(.+)_tip(.+)/g;
		$len = $2;
		$id = $1;
		$cov = $3;
		#print $current_header ."\n";
		#print $id . "\t" . $len . "\t".  $cov . "\n";
		if($cov >= 50){
			print $current_header . "\n";
			print $current_reads . "\n";
		}

		$current_header = $header;
		$current_reads = "";

	}else{
		$read = $buff;	
		$current_reads .= $read;
	}
}

$current_header =~ m/>(.+)\slength\s(\d+)\scvg_(.+)_tip(.+)/g;
$len = $2;
$id = $1;
$cov = $3;

if($cov >= 50){
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

