$reads = $ARGV[0];

my %reads_cnt;
my %buffs;

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


                if(length(trim($current_reads)) < $min && length(trim($current_reads)) != 0){
                        $min = length(trim($current_reads));
                }

                if(length(trim($current_reads)) > $max){
                        $max = length(trim($current_reads));
                }

                $current_reads = "";



print "reads: " . $reads_cnt . "\n";
print "bases: " . $bases . "\n";
print "avg length: " . ($bases/$reads_cnt) . "\n";
print "min: " . $min . "\n";
print "max: " . $max . "\n";


sub trim($)
{
	my $string = shift;
	$string =~ s/^\s+//;
	$string =~ s/\s+$//;
	return $string;
}

