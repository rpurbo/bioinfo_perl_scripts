$reads = $ARGV[0];
$gitaxa = "/data/db/nr-noneu/taxonomy/gi_taxid_prot.dmp";
$cattaxa = "/data/db/nr-noneu/taxonomy/categories.dmp";

my %git;

open (FILE, $gitaxa);
while($buff = <FILE>){
	chomp $buff;
	@token = split(/\t/, $buff);
	$gi = $token[0];
	$taxaid = $token[1];
	$git{$gi} = $taxaid; 
}
close (FILE);


my %cats;
open (FILE, $cattaxa);
while($buff = <FILE>){
        chomp $buff;
        @token = split(/\t/, $buff);
        $cat = $token[0];
        $taxaid = $token[2];
	$cats{$taxaid} = $cat;
}
close (FILE);



my %reads_cnt;
my %buffs;


$current_header = "";
$current_reads = "";

open (FILE, $reads);
while($buff = <FILE>){
	chomp $buff;
	if(substr($buff,0,1) eq ">"){
		$header = $buff;	
		#$buffs{$current_header} = $current_reads;

		$current_header =~ m/>gi\|(.+?)\|(.+)/g;
		$gi = $1;
		$taxid = $git{$gi};
		$cat = $cats{$taxid};
		#print $gi . "\t" . $taxid . "\t" .  $cat . "\n";
		if($cats{$git{$gi}} ne "E" && $current_reads ne ""){
			print $current_header . "\n";
			#print $gi . "\n";
			print $current_reads . "\n";
			$none++;		
		}

		$all++;
		$current_header = $header;		
		$current_reads = "";

	}else{
		$read = $buff;	
		$current_reads .= trim($read);
	}
}
close (FILE);

$current_header =~ m/>gi\|(.+?)\|(.+)/g;
$gi = $1;
                
if($cats{$git{$gi}} ne "E"){
	print $current_header . "\n";
	print $current_reads . "\n";            
	$none++;
}
$all++;

print STDERR $none . "\n";
print STDERR $all . "\n";

#print scalar(keys %buffs) . "\n";



sub trim($)
{
	my $string = shift;
	$string =~ s/^\s+//;
	$string =~ s/\s+$//;
	return $string;
}

