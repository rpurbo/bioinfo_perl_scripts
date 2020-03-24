$reads = $ARGV[0];
$out = $ARGV[1];

open (FILE, $reads);
open(OUT, ">" . $out);
while($buff = <FILE>){
	if(substr($buff,0,1) eq "@"){
		$header = substr($buff,1,length($buff)-1);	
		$read = <FILE>;
	
		print OUT ">" . $header;
		print OUT $read;

		
	}

	if(substr($buff,0,1) eq "+"){
                $read = <FILE>;
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

