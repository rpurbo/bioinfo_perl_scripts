use lib "/usr/local/apps/bioperl-1.6.1/lib/perl5/";

$file = $ARGV[0];

use Bio::SearchIO; 
my $in = new Bio::SearchIO(-format => 'blast', -file => $file);


my @matched = ((0) x 151);


#print $matched[0] . " " . $matched[10] . " " . $matched[120] . "\n";


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

		#print "q:" . $qn . "\n";

		$query_match = 0;
		while( my $hsp = $hit->next_hsp ){
			$l = $hsp->length("query");
			#$query_match += $l;
			@range = $hsp->range('query');
			$start = $range[0];
			$end = $range[1];

			#print "hit: " . $hn . "\n";
		 	#print "range: " . $start . "\t" . $end . "\n";	
			#print "strand: " . $hsp->strand('query') . "\n";
			#

			for ($i = $start;$i <= $end;$i++){
				$matched[$i]++;
			}
		}

		$perc = $query_match / $ql;

		#print $qn . "\t" . $ql . "\t" . $hn . "\t" .$spec . "\t" . $desc . "\t" . $bitscore . "\t" . $eval . "\t" . $perc . "\n"; 		
		last;
	}


	#$numhit = $result->num_hits;
	#print $qn . "\t" . $numhit . "\n";
	#print $counts{$qn} . "\n";
	
	#last;
}




for ($i = 0;$i < 151 ;$i++){
	print $i . "\t" .  $matched[$i] . "\n";
}



