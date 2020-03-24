#SEPARATE FASTA INTO SEVERAL SMALLER FILES FASTA @10000 reads

$file = $ARGV[0];
$folder = $ARGV[1];

my %bufs;
open(FILE, $file);
while($buff = <FILE>){
	$head = $buff;
	$reads = <FILE>;
	$p = <FILE>;
	$qual = <FILE>;
	
	$all = $head . $reads ;
	$bufs{$reads} = $all;
	$a++;
}
close(FILE);


#$dir = "chopped/";
#$dir = $folder;

$f = 0;
$id = 0;
$out = $dir . $file . "." . $id;


open (OUT, ">".$out);

for $r (keys %bufs){
	print OUT $bufs{$r};
	$f++;

	if($f % 5000 == 0  ){
		close(OUT);
		$id++;
		$out = $dir . $file . "." . $id;
		open (OUT, ">".$out);

	}

}

close(OUT);
