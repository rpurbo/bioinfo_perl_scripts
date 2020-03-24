$read1 = $ARGV[0];
$read2 = $ARGV[1];
$out = $ARGV[2];

open (FILE, $read1);
open (FILE2, $read2);
while($buff = <FILE>){
	if(substr($buff,0,1) eq "@"){
		$header = $buff;
		$header =~ m/(@.+)\s(.\:.\:.\:.)/;
		$head1 = $1 . "/1\n";	
		$read = <FILE>;
		$plus = <FILE>;
		$qual = <FILE>;


		$header2 = <FILE2>;
		$header2 =~ m/(@.+)\s(.\:.\:.\:.)/;
                $head2 = $1 . "/2\n";
		$read2 = <FILE2>;
		$plus = <FILE2>;
		$qual2 = <FILE2>;

		
		if(trim($read) ne "" && trim($read2) ne ""){
			print $head1;
			print $read;
			print $plus;
			print $qual;
			print $head2;
			print $read2;
       	        	print $plus;
       		        print $qual2;		
		}
	}

}
close (FILE);

close(FILE2);

sub trim($)
{
	my $string = shift;
	$string =~ s/^\s+//;
	$string =~ s/\s+$//;
	return $string;
}

