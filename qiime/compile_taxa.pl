$file = $ARGV[0];
my %sample;
my %id;
my %counts;
open(FILE, $file);

$buff = <FILE>;
chomp $buff;
@tok = split(/\t/, $buff);
for($i=1;$i<scalar(@tok);$i++){
	$sample{$i} = $tok[$i];
	$id{$tok[$i]} = $i;	
}

while($buff = <FILE>){
	chomp $buff;
	@tok = split(/\t/, $buff);
	$taxa = $tok[0];

	if($taxa =~ m/Bacteria/){
		for($i=1;$i<scalar(@tok);$i++){
			$count = $tok[$i];
			$name = $sample{$i};
			
			if($count > 0){
				$counts{$name}++;
			}

		}
	}

}

close(FILE);


for $name (sort keys %counts){
	print $name . "\t" . $counts{$name} . "\n";

}
