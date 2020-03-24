#REMOVE READS WITH LENGTH SMALLER THAN 200
$THRESHOLD = 300;


$file = $ARGV[0]; #FASTQ FILES
my %bufs;
open(FILE, $file);
while($buff = <FILE>){
	$head = $buff;
	$reads = <FILE>;
	$p = <FILE>;
	$qual = <FILE>;
	
	$all = $head . $reads . $p . $qual;
	$bufs{$reads} = $all;
	$a++;
}
close(FILE);


for $r (keys %bufs){
	if(length($r) > $THRESHOLD){
		$count = $r =~ tr/n|N//;
		
		if($count <= 2){
			print $bufs{$r};
			$f++;
		}

		#if($r !~ m/n|N/gi){
		#	print $bufs{$r};
		#	$f++;
		#}
	}

}

print STDERR $a . "\n";
print STDERR $f . "\n";
