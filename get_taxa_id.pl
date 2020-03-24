#get full species/chromosome entry from the original fasta files
#
$file1 = $ARGV[0];
$original = $ARGV[1];

my %tax;
my %hits;
open(FILE,$original);
while ($buff = <FILE>){
	chomp $buff;
        if($buff =~ m/>/gi){
                @token = split(/\|/, $buff);
		$ref = $token[3];
		$data = $token[scalar(@token)-1];
		$tax{$ref} = $data;

		#print $ref . "\t" . $data . "\n";
        }

}
close(FILE);


my %counts;

# SAM File

open(FILE,$file1);
while ($buff = <FILE>){
	if($buff =~ m/@/g){
		next;
	}

	chomp $buff;
	@token = split(/\t/, $buff);
	$name = $token[0];
	#$count = $token[1];
	$chr = $token[2];	

	@tok = split(/\|/,$chr);
	$ref = $tok[3];
	$data = $chr."\t" .$tax{$ref};
	#$counts{$data}++;
	$hits{$name} = $data;
	#print $id . "\t" . $data . "\t" . $count . "\n";
	$total++;
}
close(FILE);

for $name (keys %hits){
	$counts{$hits{$name}}++;
}

for $a (keys %counts){
	$perc = $counts{$a} / $total;
	print $a . "\t" . $counts{$a} . "\t" . $perc . "\n";

}



