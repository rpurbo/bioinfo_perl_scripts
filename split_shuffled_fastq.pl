$reads = $ARGV[0];

$fastq1 = $ARGV[0] . ".1";
$fastq2 = $ARGV[0] . ".2";

my %pair1;
my %pair2;
my %headers;

open (FILE1, ">" . $fastq1);
open(FILE2,">" . $fastq2);
open (FILE, $reads);
while($buff = <FILE>){
	if(substr($buff,0,1) eq "@"){
		$header = $buff;
		@tok = split(/\s/,$header);
		$header = $tok[0];
		$read = <FILE>;
		$plus = <FILE>;
		$qual = <FILE>;

		$all = $header . "/1\n". $read . $plus . $qual;
		$headers{$header}++;
		$pair1{$header} = $all;

		$header = <FILE>;
		@tok = split(/\s/,$header);
                $header = $tok[0];
                $read = <FILE>;
                $plus = <FILE>;
                $qual = <FILE>;

                $all = $header . "/2\n" . $read . $plus . $qual;
		$pair2{$header} = $all;
		$headers{$header}++;
	}

}


for $header (keys %headers){
	$cnt = $headers{$header};
	if($cnt == 2){
		print FILE1 $pair1{$header} . "";
		print FILE2 $pair2{$header} . "";

	}

}






close (FILE);
close(FILE1);
close(FILE2);


sub trim($)
{
	my $string = shift;
	$string =~ s/^\s+//;
	$string =~ s/\s+$//;
	return $string;
}

