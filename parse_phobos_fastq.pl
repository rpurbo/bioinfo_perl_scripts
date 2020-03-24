$file = $ARGV[0];
$limlen = 80;
$threh = 0.75;

my %reads;
my $repbase;
open(FILE, $file);
while($buff = <FILE>){
	chomp $buff;
	if(substr($buff,0,1) eq "#"){
		next;
	}

	if(substr($buff,0,1) eq ">"){
		#$buff =~ m/>(.+)\s+length=(\d+)\s+numreads=(\d+)/g;
		#$header = $1 . "\t" . $2 ."\t" .$3;
		#print $header . "\n";
		$header = $buff;	
	}

	if($buff =~ m/unit/g){
		$header =~ m/>(.+)\/(1|2)/g;
		#$header =~ m/>(.+)\s(1|2):(.):(.):(.)$/g;
		$name = $1;
		$pair = $2;
		#print $pair . "\n";
		@token = split(/\|/,$buff);
		$token[2] =~ m/(\d+)\sBP/g;
		$len = $1;
		$token[9] =~ m/unit\s(\w+)/g;
		$rep = $1;
		
		
	
		if($len >= $limlen){
			#print $header . "\t" .  $len . "\t" . $rep . "\n";
			if($pair == 1){
				$reads{$name}{$rep} += $len;
				#only for lane5/6 hiseq
				print STDERR $name . "\t" . $rep . "\t" . $reads{$name}{$rep} . "\t" . $len . "\n";

			}else{
				if($reads{$name}{$rep} > 0){
					print STDERR $name . "\t" . $rep . "\t" . $reads{$name}{$rep} . "\t" . $len . "\n";
					$repbase{$rep}++;
				}	
			}	
		}
	}
}
close(FILE);

for $rep (sort {$repbase{$b} <=> $repbase{$a}} keys %repbase){
	print $rep . "\t" . $repbase{$rep} . "\n";
}
