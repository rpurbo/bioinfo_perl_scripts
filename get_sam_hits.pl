#get SAM hits
#
$file1 = $ARGV[0];


open(FILE,$file1);
while ($buff = <FILE>){
	if($buff =~ m/@/gi){
		next;
	}

	chomp $buff;
	@token = split(/\t/, $buff);
	$name = $token[0];
	$flag = $token[1];
	$chr = $token[2];
	$read = $token[9];
	$qual = $token[10];

	if($chr ne "*"){
		print $buff . "\n";
	}
}
close(FILE);




