use XML::Simple;
use Data::Dumper;

my %genus_taxa;
my %phylum_taxa;
my %species_taxa;
my %all_species;
my %all_genus;
my %all_phylum;

$dir = ".";
opendir(DIR,$dir);

while($f = readdir(DIR)){
	if($f !~ m/\.xml/){
		next;
	}

	$xml = new XML::Simple;
	$data = $xml->XMLin($f);
	
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
		

		if($genus ne "NA" && $species ne "NA"){
			$species_taxa{$f}{$name} = $rel_count ;
			$all_species{$name} = 1;
		}

		if($genus ne "NA"){
			$genus_taxa{$f}{$genus} += $rel_count ;
                        $all_genus{$genus} = 1;
		}

		@tok = split(/;/,$taxa);
		$phyla = $tok[1];
		$all_phylum{$phyla} = 1;
		$phylum_taxa{$f}{$phyla} += $raw_count;


	}
}

print "sample\ttype";
for $name (keys %all_phylum){
	print "\t";
	print $name ;
}
print "\n";


for $sample (keys %phylum_taxa){
	print $sample ."\t";

	if($sample =~ m/dengue/gi){
		$type = "dengue";
	}else{
		$type = "control";
	}
	print $type;

	for $name (keys %all_phylum){
		print "\t";
		$num =  $phylum_taxa{$sample}{$name};
		if($num eq ""){
			$num =0;
		}
		print $num;

	}
	print "\n";
}





