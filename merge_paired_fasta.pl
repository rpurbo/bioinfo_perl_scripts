$reads = $ARGV[0];
$reads2 = $ARGV[1];

my %rds;

$curr_header = "";
open (FILE, $reads);
open (FILE2, $reads2);
while($buff = <FILE>){
	chomp $buff;
	if(substr($buff,0,1) eq ">"){
		$header = $buff;
		$header =~ m/>(.+)\/(.)/g;
		$header = $1;	
	}else{
		$read = $buff;
		$head = $read;	
	}


	$buff2 = <FILE2>;
	chomp $buff2;
        if(substr($buff2,0,1) eq ">"){
                $header2 = $buff2;
                $header2 =~ m/>(.+)\/(.)/g;
                $header2 = $1;
        }else{
                $read2 = $buff2;
                $tail = $read2;

		if($header eq $header2){
			print ">" . $header . "\n";
			print $head . $tail . "\n";
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

