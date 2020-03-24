$file="feat_table.txt";
open(FILE,$file);
$chrom = "";
$id = "";
$current_feat = "";
my %db;
while($buff = <FILE>){
	chomp $buff;
	if($buff =~ m/>Feature\s(.+)$/g){
		$feat = $1;
		$chrom = $1;
	}else{
		@tok = split(/\t/,$buff);
		$feat = $tok[2]; #Gene / CDS
		$st = $tok[0];
		$ed = $tok[1];
		
		if($st ne ""){
			$id = $chrom . "_" . $st . "_" . $ed ; 
			$current_feat = $feat;	
		}else{
			chomp $buff;
			@tok = split(/\t/,$buff);
			$feat2 = $tok[3];
			$val = $tok[4];

			#print $id . " - " . $current_feat . " - " . $feat2 . " - " . $val . "\n";
			$db{$id}{$current_feat}{$feat2} = $val;		
		}
	}
}
close(FILE);


for $key (keys %db){
	@tok = split(/_/,$key);
	$chrom = $tok[0];
	$st = $tok[1];
	$ed = $tok[2];

	if($ed < $st){
		$tmp = $ed;
		$ed = $st;
		$st = $tmp;
		$strand = "-";
	}else{
		$strand = "+";
	}

	$name = $db{$key}{"gene"}{"locus_tag"};
	$gene = $db{$key}{"gene"}{"gene"};
	$product = $db{$key}{"CDS"}{"product"};
	

	#print $chrom . "\t" . $st . "\t" . $ed . "\t" . $strand . "\t" . $name . "\t" . $product . "\t" . $gene . "\n";
	
	$out = "";
	$out .= $chrom . "\t" . "." . "\t" . "gene" . "\t";	
	$out .= $st . "\t" . $ed . "\t" . "." . "\t" . $strand . "\t";
	$out .= "." . "\t";
	$out .= "gene_id \"" . $name . "\";";
	
	if($gene ne ""){
		$out .= " gene_name \"" . $gene . "\";";
	}

	if($product ne ""){
		$out .= " product \"" . $product . "\";";
	}

	print $out . "\n";
}
