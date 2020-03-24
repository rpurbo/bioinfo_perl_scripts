use XML::Simple;
use Data::Dumper;

$xml = new XML::Simple;
$data = $xml->XMLin("AA020913F10.xml");

#print Dumper($data);
#print $data->{dataset}->{sequencer}->{content} . "\n";

foreach $org (@{$data->{organisms}->{organism}}){
	$name = $org->{organismName} . "";
	$rel_count = $org->{relativeAmount}->{content};
	$raw_count = $org->{relativeAmount}->{count};
	$genus = $org->{genus};
	$species = $org->{species};
	$taxa = $org->{taxonomy}->{content};

	if($name eq ""){
		$name = "NA";
	}

	if($genus eq ""){
		$name = "NA";
	}

	if($species eq ""){
		$name = "NA";
	}

	print $name ."\t" . $genus . "\t" . $species . "\t" . $taxa . "\t" . $raw_count . "\t" . $rel_count . "\n";
}


