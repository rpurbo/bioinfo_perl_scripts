use lib "/usr/local/apps/bioperl-1.6.1/lib/perl5/";

$file = $ARGV[0];

my %tax;


use Bio::SearchIO; 
my $in = new Bio::SearchIO(-format => 'blast', -file => $file);




print "Query_Name\tQuery_Length\tHit_Name\tSpecies\tHit_Desc\tBitScore\tE-Val\tId%\n";
while( my $result = $in->next_result ) {

	$qn = $result->query_name;
	$ql = $result->query_length;

	#print $qn . "\n";

	while( my $hit = $result->next_hit ) {
		$hn = $hit->name;
		$len = $hit->length;
		$bitscore = $hit->bits;
		$eval = $hit->significance;
		$desc = $hit->description;
		$desc =~ m/.*\[(.+)\].*/g;
		$spec = $1;
	
		$query_match = 0;
		while( my $hsp = $hit->next_hsp ){
			$l = $hsp->length("query");
			$query_match += $l;
		}

		$perc = $query_match / $ql;

		print $qn . "\t" . $ql . "\t" . $hn . "\t" .$spec . "\t" . $desc . "\t" . $bitscore . "\t" . $eval . "\t" . $perc . "\n"; 		
		if($bitscore >= 30){
			$tax{$spec}++;
		}

		$hit_cnt++;
	
		last;
	}


	#$numhit = $result->num_hits;
	#print $qn . "\t" . $numhit . "\n";
	#print $counts{$qn} . "\n";
	
	#last;
}


for $spec (keys %tax){
	$spec . "\t" . $tax{$spec} . "\t" . ($tax{$spec} / $hit_cnt) . "\n";
}




