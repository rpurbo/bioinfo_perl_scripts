#SEPARATE FASTQ INTO SEVERAL SMALLER FILES @10000 reads

$dir = "chopped/";
$file = $ARGV[0];
my %bufs;

$f = 1;
$id = 0;
$out = $dir . $file . "." . $id;


open (OUT, ">".$out);
open(FILE, $file);
while($buff = <FILE>){
	$head = $buff;
	$reads = <FILE>;
	$p = <FILE>;
	$qual = <FILE>;
	
	$all = $head . $reads . $p . $qual;
	
	print OUT $all;	

        if($f % 5000000 == 0  ){
                close(OUT);
                $id++;
                $out = $dir . $file . "." . $id;
                open (OUT, ">".$out);

        }

	
	$f++;
}
close(FILE);



