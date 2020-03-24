$file = $ARGV[0];
open(FILE,$file);
while($buff = <FILE>){
	$seq = <FILE>;
	chomp $seq;
	print $file . "\t" . length($seq) . "\n";
	last;
}
close(FILE);
