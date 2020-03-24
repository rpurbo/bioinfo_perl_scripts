$reads = $ARGV[0]; #454AllContigs.fna
$scaf = $ARGV[1]; #454ContigScaffolds.txt


$avg = 400;

$current_header = "";
$current_reads = "";
my %db_len;
my %db_cov;;

open (FILE, $reads);
while($buff = <FILE>){
	chomp $buff;
	if(substr($buff,0,1) eq ">"){
		$header = $buff;	
		
		if($current_reads ne ""){	
			$current_header =~ m/>(.+)(\s+)length=(\d+)(\s+)numreads=(.+)/g;
                	$len = $3;
                	$id = $1;
			$id = trim($id);
                	$cov = $5;
			$cov = ($cov * $avg) / $len;

                	#print $current_header . "\n";
                	#print $id . "\t" . $cov . "\t" . $len . "\n";		
			$db_len{$id} = $len;
			$db_cov{$id} = $cov;		
		}

		$current_header = $header;
		$current_reads = "";

	}else{
		$read = $buff;	
		$current_reads .= $read;
	}
}


$current_header =~ m/>(.+)(\s+)length=(\d+)(\s+)numreads=(.+)/g;
$len = $3;
$id = $1;
$cov = $5;
$cov = ($cov * $avg) / $len;
$db_len{$id} = $len;
$db_cov{$id} = $cov;
#print $current_header . "\n";
#print $id . "\t" . $cov . "\t" . $len . "\n";

#scaffold00001	1	2041	1	W	contig00001	1	2041	+
#scaffold00001	2042	34100	2	W	contig00002	1	32059	+
#scaffold00001	34101	34498	3	N	398	fragment	yes
#scaffold00001	34499	96865	4	W	contig00003	1	62367	+

my %maxlen;
my %cov;
my %num;

open (FILE, $scaf);
while($buff = <FILE>){
        chomp $buff;
	@token = split(/\t/, $buff);
	$id = $token[0];
	$st = $token[1];
	$ed = $token[2];
	$contig = $token[5];
	$contig = trim($contig);

	#print $id . "\t" . $st . "\t" . $ed . "\t" . $contig . "\n";

	if($maxlen{$id} eq "" || $ed > $maxlen{$id}){
		$maxlen{$id} = $ed;
	}

	if($db_cov{$contig} ne ""){
		$cov{$id} += $db_cov{$contig};
		$num{$id}++;
	}

}


for $scaf (keys %cov){
	print $scaf . "\t" . $maxlen{$scaf} . "\t" . ($cov{$scaf} / $num{$scaf}) . "\n";
}


sub trim($)
{
	my $string = shift;
	$string =~ s/^\s+//;
	$string =~ s/\s+$//;
	return $string;
}

