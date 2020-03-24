$file = $ARGV[0]; #species list

my %db;
my %genus;
my %species;
$total = 0;

open(FILE, $file);
while($buff = <FILE>){
	@token = split(/\t/, $buff);
	@token2 = split(/\s/, $token[1]);
	$species{$token[1]}++;
	$genus{$token2[0]}++;
	$total++;	
}
close(FILE);

for $spec (sort {$species{$b} <=> $species{$a}} keys %species){
	print trim($spec) . "\t" . $species{$spec} . "\n";	
	$spec_cnt++;
}

print STDERR "Species Count: " . $spec_cnt . "\n";


sub trim($)
{
	my $string = shift;
	$string =~ s/^\s+//;
	$string =~ s/\s+$//;
	return $string;
}

