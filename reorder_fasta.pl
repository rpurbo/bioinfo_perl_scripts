$reads = $ARGV[0];
$reads2 = $ARGV[1];

my %buff1;
my %buff2;
my %headers;
$current_header = "";
$current_reads = "";

open (FILE, $reads);
while($buff = <FILE>){
	chomp $buff;
	if(substr($buff,0,1) eq ">"){
		$header = $buff;
		$header =~ m/>(.+)\/(1|2)/g;		
	
		$buff1{$current_header} = $current_reads;

		$current_header = $1;
		$headers{$current_header}++;
		#print $current_header . "\n";		
		$current_reads = "";

	}else{
		$read = $buff;	
		$current_reads .= trim($read);
	}
}
close (FILE);

$buff1{$current_header} = $current_reads;


$current_header = "";
$current_reads = "";

open (FILE, $reads2);
while($buff = <FILE>){
        chomp $buff;
        if(substr($buff,0,1) eq ">"){
                $header = $buff;
		$header =~ m/>(.+)\/(1|2)/g;
                $buff2{$current_header} = $current_reads;

                $current_header = $1;
		$headers{$current_header}++;	
                $current_reads = "";

        }else{
                $read = $buff;
                $current_reads .= trim($read);
        }
}
close (FILE);

$buff2{$current_header} = $current_reads;

$out1 = "paired.fa.1";
$out2 = "paired.fa.2";
$out3 = "singles.fa";

open (OUT1 , ">" . $out1);
open (OUT2 , ">" . $out2);
open (OUT3 , ">" . $out3);

for $header (keys %headers){
	$f1 = $buff1{$header};
	$f2 = $buff2{$header};

	if($f1 ne "" && $f2 ne ""){
		$f1h = ">" . $header . "/1";
		$f2h = ">" . $header . "/2";
		print OUT1 $f1h . "\n";
		print OUT1 $f1 . "\n";
		print OUT2 $f2h . "\n";
		print OUT2 $f2 . "\n";
		$pairs++;
	}else{
		if($f1 ne ""){
			$f1h = ">" . $header . "";
			print OUT3 $f1h . "\n";
			print OUT3 $f1 . "\n";
			$fw++;
		}else{
			$f2h = ">" . $header . "";
                        print OUT3 $f2h . "\n";
                        print OUT3 $f2 . "\n";
			$rev++;
		}
	}

}
                

close(OUT1);
close(OUT2);
close(OUT3);


print STDERR "paired: " . $pairs . "\n";
print STDERR "forward only: " . $fw . "\n";
print STDERR "reverse only: " . $rev . "\n";



sub trim($)
{
	my $string = shift;
	$string =~ s/^\s+//;
	$string =~ s/\s+$//;
	return $string;
}

