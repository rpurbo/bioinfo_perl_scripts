$file = $ARGV[0];
open(FILE, $file);
while($buff = <FILE>){
	chomp $buff;
	$head = $buff;
	$nuc = <FILE>;
	$plus = <FILE>;
	$qual = <FILE>;

	$len = length($nuc);
	print $head . "\t" . $len . "\n";

}
close(FILE);


