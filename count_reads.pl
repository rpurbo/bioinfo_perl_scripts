$dir = ".";
opendir(DIR,$dir);
while($f = readdir(DIR)){
	if($f =~ m/Sample/g){
		$com = "zcat " . $f . "/*R1* | grep \@HWI | wc -l";
		$res = `$com`;
		chomp $res;
		print $f . "\t" . $res . "\n";
	}
}
closedir(DIR);
