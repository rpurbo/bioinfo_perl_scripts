$reads1 = $ARGV[0];
$reads2 = $ARGV[1];

my %buff1;
my %buff2;
my %headers;

open (FILE, $reads1);
while($buff = <FILE>){
	if(substr($buff,0,1) eq "@"){
		$header = $buff;
		#$header =~ m/@(.+)\/(1|2)/g;		
		$header =~ m/@(.+)\s(1|2)\:.\:.\:.$/g;
		$reads = <FILE>;
		$plus = <FILE>;
		$qual = <FILE>;
		$name = $1;	
		#print $name . "\n";
		$all = $header . $reads . $plus . $qual;
		$buff1{$name} = $all;
		$headers{$name} = 1;
	}
}
close (FILE);

open (FILE, $reads2);
while($buff = <FILE>){
        if(substr($buff,0,1) eq "@"){
                $header = $buff;
                #$header =~ m/@(.+)\/(1|2)/g;
                $header =~ m/@(.+)\s(1|2)\:.\:.\:.$/g;
		$reads = <FILE>;
                $plus = <FILE>;
                $qual = <FILE>;
                $name = $1;
                $all = $header . $reads . $plus . $qual;
                $buff2{$name} = $all;
                $headers{$name} = 1;
        }
}
close (FILE);



#$out1 = "paired.1.fq";
#$out2 = "paired.2.fq";
#$out3 = "singles.fq";
$out1 = $reads1 . ".1.fq";
$out2 = $reads2 . ".2.fq";
$out3 = $reads1. ".singleton.fq";

open (OUT1 , ">" . $out1);
open (OUT2 , ">" . $out2);
open (OUT3 , ">" . $out3);

for $header (keys %headers){
	#print $header . "\n";
	$f1 = trim($buff1{$header});
	$f2 = trim($buff2{$header});

	if($f1 ne "" && $f2 ne ""){
		print OUT1 $f1 ;
		print OUT2 $f2 ;
		$pairs++;
	}else{
		
		if($f1 ne ""){
			print OUT3 $f1 ;
			$fw++;
		}else{
                        print OUT3 $f2 ;
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

