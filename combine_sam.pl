#Consolidate multiple SAM aligment files from partitioned-large-database (>4GB)

$file1 = $ARGV[0];
$file2 = $ARGV[1];

my %db;
my %scores;
my %reads;
my %cumulative;
my %buffers;
my $heads;

$header = "";
open(FILE,$file1);
while ($buff = <FILE>){
	if($buff =~ m/@/gi){
		#$header .= $buff;
		$heads{$buff}++;
		next;
	}

	chomp $buff;
	@token = split(/\t/, $buff);
	$name = $token[0];
	$flag = $token[1];
	$chr = $token[2];
	$qscore = $token[4];	
	$read = $token[9];
	$qual = $token[10];

	#print $flag . "\n";

	if($chr ne "*"){
		#print $flag . "\n";
		if($db{$name} eq "" && $qscore >= 15){
			#if($flag & 2){
				$db{$name} = $chr;
				$cumulative{$chr}++;
				$scores{$name} = $qscore;
				$buffers{$name} = $buff;
			#}
		}
	}
	
	$reads{$name} = 1;
}
close(FILE);




open(FILE,$file2);
while ($buff = <FILE>){
        if($buff =~ m/@/gi){
		$heads{$buff}++;
                next;
        }

        chomp $buff;
        @token = split(/\t/, $buff);
        $name = $token[0];
        $flag = $token[1];
        $chr = $token[2];
	$qscore = $token[4];
        $read = $token[9];
        $qual = $token[10];

        if($chr ne "*"){
                if($db{$name} eq ""){
			#if($flag & 2){
                        	$db{$name} = $chr;
				$cumulative{$chr}++;
				$buffers{$name} = $buff;
			#}
                }else{
			if($qscore > $scores{$name}){
				$db{$name} = $chr;
                                $cumulative{$chr}++;
				$buffers{$name} = $buff;

			}

		}
        }
}
close(FILE);

for $chr (keys %cumulative){
	#print $chr . "\t" . $cumulative{$chr} . "\n";
		
}

#print $header;
for $a (keys %heads){
	print $a ;
}

for $name (keys %buffers){
	print $buffers{$name} . "\n";

}




