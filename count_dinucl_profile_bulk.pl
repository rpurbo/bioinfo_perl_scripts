#count dinucleotide frequency from a list of fastq 
#
$list = $ARGV[0];

my %din;
my %base;

$base{"0"} = "A";
$base{"1"} = "C";
$base{"2"} = "G";
$base{"3"} = "T";

for ($i=0;$i<4;$i++){
	for ($j=0;$j<4;$j++){
		$alp = $base{$i} . $base{$j};
		#print $alp . "\n";
		$din{$alp} = 0;	
	}
}



open(LIST,$list);
while($file = <LIST>){
	#print $file;
	chomp $file;
	open(FILE, $file);
	while($buff = <FILE>){
		$head = $buff;
	
		$reads = <FILE>;
		chomp $reads;
		$p = <FILE>;
		$qual = <FILE>;
	
		for($i=0;$i<length($reads) - 1;$i++){
			$nuc = uc(substr(($reads,$i,2)));
			if($nuc !~ m/N|n/g && length($nuc) == 2){
				$din{$nuc}++;
				#print $nuc . "\n";
			}
		}

	}
	close(FILE);
}

#last;
close(LIST);


for $bases (keys %din){
	print $bases . "\t" . $din{$bases} . "\n";
}
