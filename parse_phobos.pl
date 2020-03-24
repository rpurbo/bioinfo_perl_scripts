$file = $ARGV[0];
my %sorts;
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
		@token = split(/\|/,$buff);
		$token[2] =~ m/(\d+)\sBP/g;
		$len = $1;
		$token[9] =~ m/unit\s(\w+)/g;
		$rep = $1;
		if($len >= 500){
			#print $header . "\t" .  $len . "\t" . $rep . "\n";
			$key = $header . "\t" .  $len . "\t" . $rep . "\n";
			$sorts{$key} = $len;		
		}
	}
}
close(FILE);


for $key (sort {$sorts{$b} <=> $sorts{$a}} %sorts){
	print $key;

}

