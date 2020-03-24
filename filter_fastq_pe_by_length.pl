$file = $ARGV[0]; #FASTQ FILES
$file2 = $ARGV[1];
$prefix = $ARGV[2];
$length = $ARGV[3];

open(OUT1, ">".$prefix . ".R1.filt.fastq");
open(OUT2, ">".$prefix . ".R2.filt.fastq");

open(FILE, $file);
open(FILE2, $file2);
while($buff = <FILE>){
	$head = $buff;
	$reads = <FILE>;
	$p = <FILE>;
	$qual = <FILE>;
	
	$head2 = <FILE2>;
        $reads2 = <FILE2>;
        $p2 = <FILE2>;
        $qual2 = <FILE2>;

	if(length($reads) > $length && length($reads2) > $length){
		print OUT1 $head ;
		print OUT1 $reads;
		print OUT1 $p;
		print OUT1 $qual;

                print OUT2 $head2 ;
                print OUT2 $reads2;
                print OUT2 $p2;
                print OUT2 $qual2;
	}

}
close(FILE);
close(FILE2);
close(OUT1);
close(OUT2);

