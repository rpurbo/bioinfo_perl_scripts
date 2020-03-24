$file = $ARGV[0]; #species list

my %db;
my %genus;
my %species;
$total = 0;

open(FILE, $file);
while($buff = <FILE>){
	@token = split(/\t/, $buff);
	@token2 = split(/\s/, $token[1]);
	$species{$buff}++;
	$genus{$token2[0]}++;
	$total++;	
}
close(FILE);

for $gen (sort {$genus{$b} <=> $genus{$a}} keys %genus){
	print $gen . "\t" . $genus{$gen} . "\n";	
	$genus_cnt++;
}

print STDERR "Genus Count: " . $genus_cnt . "\n";
