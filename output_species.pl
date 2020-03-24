#PRINT SPECIES LIST FROM BWA RESULT

$file = $ARGV[0];   #BWA result
open(FILE, $file);
while($buff = <FILE>){
	if($buff !~ m/\@SQ/gi){
		@token = split(/\t/, $buff);
		$species = $token[2];
		$header = $token[0];
		if($species !~ m/\*/gi){
			print $header . "\t" . $species . "\n";
			$found++;
		}
			
		$all++;
	}

}
close(FILE);


print STDERR "found: " . $found . "\n";
print STDERR "all: " . $all . "\n";
