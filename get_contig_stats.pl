$reads = $ARGV[0];

my %reads_cnt;
my %buffs;
my %lengths;

my $reads_cnt = 0;
my $bases = 0;
my $filtered = 0;
$min = 10000000000;
$max = 0;

$current_header = "";
$current_reads = "";

open (FILE, $reads);
while($buff = <FILE>){
	if(substr($buff,0,1) eq ">"){
		$header = $buff;	
		$current_header = $header;		
			
		$reads_cnt++;
		$bases += length(trim($current_reads)); 
		$lengths{$header} = length(trim($current_reads));

		if(length(trim($current_reads)) < $min && length(trim($current_reads)) != 0){
			$min = length(trim($current_reads));
		}
		
		if(length(trim($current_reads)) > $max){
			$max = length(trim($current_reads));
		}

		$current_reads = "";

	}else{
		$read = $buff;	
		$current_reads .= trim($read);
	}
}
close (FILE);

$bases += length(trim($current_reads));
$lengths{$header} = length(trim($current_reads));
if(length(trim($current_reads)) < $min && length(trim($current_reads)) != 0){
	$min = length(trim($current_reads));
}

if(length(trim($current_reads)) > $max){
	$max = length(trim($current_reads));
}


$half = $bases / 2;
$sum = 0;
for $head (sort {$lengths{$b} <=> $lengths{$a}} keys %lengths){
	#print $head . "\t" . $lengths{$head} . "\n";
	$sum += $lengths{$head};
	if($sum > $half){
		$n50 = $lengths{$head};
		last;
	}	
}


print STDERR "reads: " . $reads_cnt . "\n";
print STDERR "bases: " . $bases . "\n";
print STDERR "avg length: " . ($bases/$reads_cnt) . "\n";
print STDERR "min: " . $min . "\n";
print STDERR "max: " . $max . "\n";
print STDERR "N50: " . $n50 . "\n";

sub trim($)
{
	my $string = shift;
	$string =~ s/^\s+//;
	$string =~ s/\s+$//;
	return $string;
}

