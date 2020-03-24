$dir = ".";
my %covs;
my %gcs;
$window = 50000;
opendir(DIR,$dir);
while($f = readdir(DIR)){	
	if($f =~ m/txt/){
		# calculate coverages
		open(FILE, $f);
		#print $f . "\n";
		$f =~ m/(.+)\.cov\.txt/;
		$id = $1;

		$sum=0;
		$cnt=0;
		$bucket=0;

		while($buff = <FILE>){
			chomp $buff;
			@tok = split(/\s/,$buff);
			$coord = $tok[1];
			$cov = $tok[2];

			$sum+=$cov;
			$cnt++;	

			if($cnt == $window){		
				$cnt=0;
				$avg = $sum / $window;
				$bucket++;
				$sum = 0;	
				print $id . "\t" . ($bucket*100) . "\t" . $avg . "\n";
				#$covs{$id}{$bucket} = $avg;
			}
		}
		$avg = $sum / $cnt;
		$bucket++;
		print $id . "\t" . ($bucket*100) . "\t" . $avg . "\n";
		#$covs{$id}{$bucket} = $avg;
		close(FILE);


	}
}
closedir(DIR);
