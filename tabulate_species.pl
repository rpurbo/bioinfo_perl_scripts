#get full species/chromosome entry from the original fasta files
#
$file1 = $ARGV[0];

my %db;
# <Ref>	<count>
open(FILE,$file1);
while ($buff = <FILE>){

	chomp $buff;
	@token = split(/\t/, $buff);
	$id = $token[0];
	$ref = $token[1];
	$count = $token[2];

	@tok = split(/\s/,$ref);
	$spec = "" . $tok[1] . " " . $tok[2];
	
	$db{$spec} += $count;
	#print $spec . "\n";	
}
close(FILE);

for $spec (keys %db){
	print $spec . "\t" . $db{$spec} . "\n"; 
}


