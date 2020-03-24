$reads = $ARGV[0];

$longest = 0;
$current_header = "";
$current_reads = "";
my %db;

my $n = 0;
my $all = 0;

open (FILE, $reads);
while($buff = <FILE>){
	chomp $buff;
	if(substr($buff,0,1) eq ">"){
		$header = $buff;	

	}else{
		$current_reads .= $buff;
	}
}
$read = $current_reads;

$num =0;
$min =0;
$max = 1000000;
$b = 0;
my %dbs;
while($read =~ m/(N+)/g){
	$num++;
	$gap = $1;
	$len = length($gap);
	if($len > $min){$min = $len;}
        if($len > 1  && $len < $max){
		$max = $len;
	}

	if($len > 0){
		$dbs{$num} = $len;
		$b++;
	}
}


print "Number of Gaps:" . $num . "\n";
print ">100bp Gaps:" . $b . "\n";
print "Largest Gap:" . $min . "\n";
print "Smallest Gap:" . $max . "\n";
print "=======================\n";

for $key (sort {$dbs{$b} <=> $dbs{$a}} keys %dbs){
	print $dbs{$key} . "\n";

}


sub trim($)
{
	my $string = shift;
	$string =~ s/^\s+//;
	$string =~ s/\s+$//;
	return $string;
}

