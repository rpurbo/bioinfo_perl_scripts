$file = $ARGV[0]; #FASTQ FILES
$length = $ARGV[1];


my %bufs;
open(FILE, $file);
while($buff = <FILE>){
	$head = $buff;
	$reads = <FILE>;
	$p = <FILE>;
	$qual = <FILE>;
	
	if(length($reads) > $length){
		print $head ;
		print $reads;
		print $p;
		print $qual;
	}

}
close(FILE);


