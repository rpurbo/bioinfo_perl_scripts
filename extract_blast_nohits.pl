#my %gi2tax;
#$file = "db/gi_taxid_prot.map";
#open(FILE, $file);
#while($buff = <FILE>){
#        chomp $buff;
#        @tok = split(/\t/, $buff);
#        $gi2tax{$tok[0]} = $tok[1];
#}
#close(FILE);

#print STDERR "Finish Loading Table\n";


my %hit;
my %hit_score;
my %hit_eval;

my $query = "";
my $gi = "";
my $record = "";
$file = $ARGV[0];
$fasta1 = $ARGV[1];
$fasta2 = $ARGV[2];
$out = $ARGV[3];


my %headers;

open(FILE, $file);
open(OUT,">" . $out);

while($buff = <FILE>){
	if($buff =~ m/Query=\s(.+)/g){
		$name = $1;
	}
	
	if($buff =~ m/No hits/g){
		#print OUT $name . "\n";
		$headers{$name} = 1;		
		$name = "";
	}		

}
close(FILE);

open(FILE, $fasta1);
while($buff = <FILE>){
	if($buff =~ m/>(.+)/g){
		$head = $1;
		$read = <FILE>;
		chomp $head;
		chomp $read;

		if($headers{$head}){
			print OUT ">" . $head . "\n";
			print OUT $read . "\n";
		}
	}
		
}
close(FILE);


open(FILE, $fasta2);
while($buff = <FILE>){
        if($buff =~ m/>(.+)/g){
                $head = $1;
                $read = <FILE>;
                chomp $head;
                chomp $read;

                if($headers{$head}){
                        print OUT ">" . $head . "\n";
                        print OUT $read . "\n";
                }
        }

}
close(FILE);


close(OUT);






