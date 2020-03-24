use lib "/usr/local/apps/bioperl-1.6.1/lib/perl5/";

$file = $ARGV[0];
$fasta = $ARGV[1];

my %reads;

open(FILE, $fasta);
while($buff = <FILE>){
	chomp $buff;
	if($buff =~ m/>/g){
		$header = $buff;	
		$read = <FILE>;
		chomp $read;
		$header =~ m/(.+)\slen(.+)/g;
		#print $1 . "\n";
		$header = $1;
		$reads{$header} = $read;
	}


}
close(FILE);


use Bio::SearchIO; 
my $in = new Bio::SearchIO(-format => 'blast', -file => $file);

while( my $result = $in->next_result ) {

	$qn = $result->query_name;
	$ql = $result->query_length;
	$hit = $result->num_hits; 
	#print $qn . "\n";

	if($hit == 0){
		#print $qn . "\n";
		#print 
		$header = ">" . $qn ;
		print $header . "\n";
		print $reads{$header} . "\n";
	}

}






