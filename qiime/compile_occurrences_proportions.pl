use Statistics::Test::WilcoxonRankSum;


$file = $ARGV[0];
my %sample;
my %id;
my %counts;
my %taxadb;
open(FILE, $file);

$buff = <FILE>;
chomp $buff;
@tok = split(/\t/, $buff);
for($i=1;$i<scalar(@tok);$i++){
	$sample{$i} = $tok[$i];
	$id{$tok[$i]} = $i;	
}

while($buff = <FILE>){
	chomp $buff;
	@tok = split(/\t/, $buff);
	$taxa = $tok[0];

	@taxatok = split(/__/,$taxa);

	if($taxa =~ m/Bacteria/ && $taxa !~ m/Other/){
		#$taxa = $taxatok[scalar(@taxatok)-1];
		$taxadb{$taxa} = 1;

		for($i=1;$i<scalar(@tok);$i++){
			$count = $tok[$i];
			$name = $sample{$i};
			$count = $count * 100;
			$counts{$name}{$taxa} = $count;		
		}
	}

}
close(FILE);


my %controldb;
for $name (keys %counts){
	if($name !~ m/control/){
		next; 
	}

        for $taxa (keys %{$counts{$name}}){
		if($counts{$name}{$taxa} > 0 ){
			$controldb{$taxa}++;
		}
        }
}


my %pkchdb;
for $name (keys %counts){
        if($name !~ m/PKCH/){
                next;
        }

        for $taxa (keys %{$counts{$name}}){
                if($counts{$name}{$taxa} > 0 ){
                        $pkchdb{$taxa}++;
                }
        }
}


my %pkcldb;
for $name (keys %counts){
        if($name !~ m/PKCL/){
                next;
        }

        for $taxa (keys %{$counts{$name}}){
                if($counts{$name}{$taxa} > 0 ){
                        $pkcldb{$taxa}++;
                }
        }
}


print "PKCH \n";
for $taxa (keys %taxadb){
        if($controldb{$taxa} eq ""){
                $control = 0;
        }else{
                $control = $controldb{$taxa};
        }

        if($pkchdb{$taxa} eq ""){
                $pkch = 0;
        }else{
                $pkch = $pkchdb{$taxa};
        }

        print $taxa . "\t" . $pkch . "\t" . $control . "\n";

}


print "\n\n";
print "PKCL \n";
for $taxa (keys %taxadb){
        if($controldb{$taxa} eq ""){
		$control = 0;
	}else{
		$control = $controldb{$taxa};
	}

        if($pkcldb{$taxa} eq ""){
                $pkcl = 0;
        }else{
                $pkcl = $pkcldb{$taxa};
        }

        print $taxa . "\t" . $pkcl . "\t" . $control . "\n";

}



