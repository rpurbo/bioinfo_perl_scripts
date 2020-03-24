$reads = $ARGV[0];
$prefix = $ARGV[1];
$split_num = $ARGV[2];


$current_header = "";
$current_reads = "";
my %db;

open (FILE, $reads);
while($buff = <FILE>){
	chomp $buff;
	if(substr($buff,0,1) eq ">"){
		$header = $buff;	
			
		$reads_cnt++;

		$db{$current_header} = $current_reads;
		$current_header = $header;
		$current_reads = "";

	}else{
		$read = $buff;	
		$current_reads .= $read;
	}
}
close (FILE);
$db{$current_header} = $current_reads;


$num = int($reads_cnt / $split_num)+1;

$out = $prefix . ".out.1.fasta"; 
open (OUT, ">" . $out);
$i = 0;
$cnt = 1;
for $a (keys %db){
	
	$i++;
	if($i % $num == 0){
		close(OUT);
		$cnt++;
		$out = $prefix . ".out." . $cnt . ".fasta";	
		open (OUT , ">" . $out);
	}

	print OUT $a . "\n";
	print OUT $db{$a} . "\n";
}
close(OUT);


sub trim($)
{
	my $string = shift;
	$string =~ s/^\s+//;
	$string =~ s/\s+$//;
	return $string;
}

