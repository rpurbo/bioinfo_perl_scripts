$file = $ARGV[0];
$readlen = 101;
$insert = 5000;
$dev = 300;
$step = 50;
$cov = 30;
$genome = 650000000;
$bases = $genome * $cov;


$current_header = "";
$current_reads = "";
my %db;

open (FILE, $file);
while($buff = <FILE>){
        chomp $buff;
        if(substr($buff,0,1) eq ">"){
                $header = $buff;

                if($current_reads ne "") {
                    $db{$current_header} = $current_reads;       
                }

                $current_header = $header;
                $current_reads = "";

        }else{
                $read = $buff;
                $current_reads .= $read;
        }
}
$db{$current_header} = $current_reads; 

$id = 1;
$curr_bases = 0;

do{
	for $contig (keys %db){

		$contig =~ m/>(.+?)\s(.+)/g;
		$name = $1;
		#print $name . "\n";

		$seq = $db{$contig};
		if(length($seq) < ($insert + $dev)){
			next;
		}

		#print $contig . "\t" . length($contig) . "\n";
	
		$init = int(rand($step));
		for($st = $init; $st < length($seq);$st += $step){
			$idev = int(rand(2*$dev));
			$trudev = $idev - $dev;
			$truinsert = $insert + $trudev;
			$distance = $truinsert - $readlen;
	
			$head = uc(substr($seq,$st,$readlen));
			
			$st2 = $st + $distance;
			
			if(($st2 + $readlen) > length($seq)){
				last;
			}
			
			$tail = uc(substr($seq,$st2,$readlen));
			
			$a = $head =~ tr/N//;
			$b = $tail =~ tr/N//;

			if($a < 3 && $b < 3){
				print ">" . $name . "_" .$id . "_"  . $st . "/0" . "\n";
				print $head . "\n";
				print ">" . $name . "_" . $id . "_" .  $st2 . "/1" . "\n";
				print $tail . "\n";
				$curr_bases += 2 * $readlen;
			}

			$id++;
		}
	}
	
	print STDERR "prog: " . ($curr_bases / $genome) . "\n";
 
}while($curr_bases < $bases);



sub revcomp{
	$seq = $_[0];
	$seq = uc($seq);
		
	my %nuc;
	$nuc{"A"} = "T";
	$nuc{"C"} = "G";
	$nuc{"G"} = "C";
	$nuc{"T"} = "A";	
	$nuc{"N"} = "N";

	$rev = reverse($seq);
	$sub = "";	
	for($i=0;$i<length($rev);$i++){
		$sub .= $nuc{substr($rev,$i,1)};
	}

	return $sub;
}




