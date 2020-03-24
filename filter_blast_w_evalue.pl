$file = $ARGV[0];
open(FILE,$file);
while($buff = <FILE>){
	@token = split(/\t/, $buff);
	$evalue = $token[2];
	if($evalue > 0.0000000000000000000000000000000000000001){
		$cnt++;
		print $buff;
	}

	$all++;
}
close(FILE);


print STDERR "Pass: " . $cnt . "\n";
print STDERR "All: " . $all . "\n";
