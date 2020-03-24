
$file = $ARGV[0]; #original fasta
$out1 = $file . ".R1";
$out2 = $file . ".R2";

open(OUT1,">" . $out1);
open(OUT2,">" . $out2);

my %heads;
my %reads1;
my %reads2;

open(FILE,$file);
while($buff = <FILE>){
        chomp $buff;
        if(substr($buff,0,1) eq ">"){
		$buff =~ m/>(.+)\/(.)/g; 
		$head = $1;
		$pair = $2;
		$seq = <FILE>;	
		chomp $seq;
		
		$heads{$head}++;		

		if($pair == 1){
			$reads1{$head} = $seq;
		}else{
			$reads2{$head} = $seq;
		}
       }

}
close(FILE);


for $name (keys %heads){
	$num = $heads{$name};
	if($num > 1){
		print OUT1 ">" . $name . "/1\n";
		print OUT1 $reads1{$name} . "\n";

		print OUT2 ">" . $name . "/2\n";
                print OUT2 $reads2{$name} . "\n";
	}


}


close(OUT1);
close(OUT2);

