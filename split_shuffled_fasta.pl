$reads = $ARGV[0];

$fasta1 = $ARGV[0] . ".1";
$fasta2 = $ARGV[0] . ".2";

open (FILE1, ">" . $fasta1);
open(FILE2,">" . $fasta2);
open (FILE, $reads);
while($buff = <FILE>){
	if(substr($buff,0,1) eq ">"){
		#$header = substr($buff,1,length($buff)-1);	
		$header = $buff;
		$read = <FILE>;

		$all = $header . $read ;
		print FILE1 $all;

		$header = <FILE>;
                $read = <FILE>;

                $all = $header . $read ;
                print FILE2 $all;

	
		#print ">" . $header;
		#print $read;

		
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

