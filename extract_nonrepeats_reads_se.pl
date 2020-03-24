$nonrepeat = $ARGV[0];
$reads = $ARGV[1];

my %db;
open (FILE, $nonrepeat);
while($buff = <FILE>){
	@token = split(/\t/,$buff);
	$head = $token[0];
	$db{$head} = 1;	
}
close (FILE);


open (FILE, $reads);
$out = $reads . ".nonrep";
open(OUT, ">" . $out);
while($buff = <FILE>){
	if(substr($buff,0,1) eq "@"){
		$header = $buff;
		#ILLUMINA HISEQ
		$header =~ m/@(.+)\/(1|2)/g;
		$name = $1;

		#ILLUMINA MISEQ
		#@M00180:15:000000000-A0JVU:1:1:16524:1429 1:N:0:1		
		#$header =~ m/@(.+):(.+):(.+):(.+):(.+):(.+):(.+)\s(1|2):.:.:.$/g;
		#$name = $1 . $2 . $3 . ":" . $4 . ":" . $5 . ":" . $6 . ":" . $7 . "#0"; 
		#print $name . "\n";

		$read = <FILE>;
		$plus = <FILE>;
		$qual = <FILE>;
		$all = $header . $read . $plus . $qual;
		if($db{$name} != 1){
			print OUT $all;
		}else{
			#print $all;
		}
		
	}

}
close (FILE);
close(OUT);


sub trim($)
{
	my $string = shift;
	$string =~ s/^\s+//;
	$string =~ s/\s+$//;
	return $string;
}

