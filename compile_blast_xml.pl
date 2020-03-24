use XML::LibXML;

my $hit_cnt = 0;
my $cnt = 0;

$dirtoget= $ARGV[0];
$hits_file= $ARGV[1];
$unmapped= $ARGV[2];

open (OUTPUT, ">$hits_file");
open (NOHITS, ">$unmapped");

opendir(IMD, $dirtoget) || die("Cannot open directory");
@thefiles= readdir(IMD);
closedir(IMD);

foreach $file (@thefiles)
{
	#$file = $ARGV[0] ; #Blast XML file
	print STDERR "Processing: " . $file . "\n" ;

	if($file !~ m/blast/gi){
		next;
	}
	  
	my $parser = XML::LibXML->new();
	my $tree = $parser->parse_file($file);
	my $root = $tree->getDocumentElement;

	my @results = $root->getElementsByTagName('Iteration');

	for my $result(@results){
		my $query = $result->findvalue('Iteration_query-def');
		my $msg = $result->findvalue('Iteration_message');
		$cnt++;

		if(trim($msg) ne ""){	#No Hit
			print NOHITS $query . "\n";
			next;
		}

		my @iter_hits = $result->getElementsByTagName('Iteration_hits');
		my @hits = $iter_hits[0]->getElementsByTagName('Hit');
		my @hit_hsps = $hits[0]->getElementsByTagName('Hit_hsps');
		my @hsps = $hit_hsps[0]->getElementsByTagName('Hsp');
		
		my $hit_name = $hits[0]->findvalue('Hit_def');
		my $evalue = $hsps[0]->findvalue('Hsp_evalue');
		my $bitscore = $hsps[0]->findvalue('Hsp_bit-score');
	
		@token = split(/\|/,$hit_name);
		$name = $token[1];

		print OUTPUT $query . "\t" . $name . "\t" . $evalue . "\t" . $bitscore . "\n";

		$hit_cnt++;

	}
}

close(OUTPUT);
close(NOHITS);

print STDERR "Hit Count: " ;
print STDERR $hit_cnt . "\n";
print STDERR "Count: " ;
print STDERR $cnt . "\n";


sub trim($)
{
	my $string = shift;
	$string =~ s/^\s+//;
	$string =~ s/\s+$//;
	return $string;
}

