use Statistics::Test::WilcoxonRankSum;
use Statistics::Multtest qw(:all);

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
			if($count == 0){
				$count = 0.0001;
			}
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
		$controldb{$taxa} .= $counts{$name}{$taxa} . ";";
        }
}


my %pkchdb;
for $name (keys %counts){
        if($name !~ m/PKCH/){
                next;
        }

        for $taxa (keys %{$counts{$name}}){
                $pkchdb{$taxa} .= $counts{$name}{$taxa} . ";";
        }
}


my %pkcldb;
for $name (keys %counts){
        if($name !~ m/PKCL/){
                next;
        }

        for $taxa (keys %{$counts{$name}}){
                $pkcldb{$taxa} .= $counts{$name}{$taxa} . ";";
        }
}



# PKCH - CONTROL comparisons

print "PKCH \n";
my %pkchadjpval = ();
my %pkchpval = ();

for $taxa (keys %taxadb){
        $control = $controldb{$taxa};
        $pkch = $pkchdb{$taxa};

        my @controltok;
        @controltok = split(/;/,$control);
        @controltok = sort {$a<=>$b} (@controltok);
        $controlmed = ($controltok[1] + $controltok[2]) / 2;

        my @pkchtok;
        @pkchtok = split(/;/,$pkch);
        @pkchtok = sort {$a<=>$b} (@pkchtok);
        $pkchmed = ($pkchtok[1] + $pkchtok[2]) / 2;

        my $wilcox_test = Statistics::Test::WilcoxonRankSum->new();
        $wilcox_test->load_data(\@pkchtok, \@controltok);
        my $prob = $wilcox_test->probability();
	
	print "\n===============\n";
	print (join " - ", @controltok) . "";
	print "\n";
	print (join " - ", @pkchtok) . "";
	print "\n";
	$wilcox_test->summary();
	$pkchpval->{$taxa} = $prob;
}

$pkchadjpval = BH($pkchpval);

for $taxa (keys %taxadb){
	$control = $controldb{$taxa};
	$pkch = $pkchdb{$taxa};

	my @controltok;
	@controltok = split(/;/,$control);
	@controltok = sort {$a<=>$b} (@controltok);
	$controlmed = ($controltok[1] + $controltok[2]) / 2;

	my @pkchtok;
        @pkchtok = split(/;/,$pkch);
        @pkchtok = sort {$a<=>$b} (@pkchtok);
	$pkchmed = ($pkchtok[1] + $pkchtok[2]) / 2;

	if($pkchmed == 0.0001){
		$pkchmed = 0;
	}
        if($controlmed == 0.0001){
                $controlmed = 0;
        }
	if($pkchtok[0] == 0.0001){
                $pkchtok[0] = 0;
        }
        if($pkchtok[3] == 0.0001){
                $pkchtok[3] = 0;
        }
        if($controltok[0] == 0.0001){
                $controltok[0] = 0;
        }
        if($controltok[3] == 0.0001){
                $controltok[3] = 0;
        }

	print $taxa . "\t";
	printf ("%.2f \(%.2f-%.2f\)", $pkchmed,  $pkchtok[0], $pkchtok[3]);
	
	print "\t";
	printf ("%.2f \(%.2f-%.2f\)", $controlmed,  $controltok[0], $controltok[3]);
	print "\t";
	printf ("%.2f\n", $pkchadjpval->{$taxa}) ;

}



print "\n\n";
print "PKCL \n";

my %pkcladjpval = ();
my %pkclpval = ();

for $taxa (keys %taxadb){
        $control = $controldb{$taxa};
        $pkcl = $pkcldb{$taxa};

        my @controltok;
        @controltok = split(/;/,$control);
        @controltok = sort {$a<=>$b} (@controltok);
        $controlmed = ($controltok[1] + $controltok[2]) / 2;

        my @pkcltok;
        @pkcltok = split(/;/,$pkcl);
        @pkcltok = sort {$a<=>$b} (@pkcltok);
        $pkclmed = ($pkcltok[1] + $pkcltok[2]) / 2;

        my $wilcox_test = Statistics::Test::WilcoxonRankSum->new();
        $wilcox_test->load_data(\@pkcltok, \@controltok);
        my $prob = $wilcox_test->probability();
        $pkclpval->{$taxa} = $prob;
}

$pkcladjpval = BH($pkclpval);

for $taxa (keys %taxadb){
        $control = $controldb{$taxa};
        $pkcl = $pkcldb{$taxa};

        my @controltok;
        @controltok = split(/;/,$control);
        @controltok = sort {$a<=>$b} (@controltok);
        $controlmed = ($controltok[1] + $controltok[2]) / 2;

        my @pkcltok;
        @pkcltok = split(/;/,$pkcl);
        @pkcltok = sort {$a<=>$b} (@pkcltok);
        $pkclmed = ($pkcltok[1] + $pkcltok[2]) / 2;


        if($pkclmed == 0.0001){
                $pkclmed = 0;
        }
        if($controlmed == 0.0001){
                $controlmed = 0;
        }
        if($pkcltok[0] == 0.0001){
                $pkcltok[0] = 0;
        }
        if($pkcltok[3] == 0.0001){
                $pkcltok[3] = 0;
        }
        if($controltok[0] == 0.0001){
                $controltok[0] = 0;
        }
        if($controltok[3] == 0.0001){
                $controltok[3] = 0;
        }

        print $taxa . "\t";
	printf ("%.2f \(%.2f-%.2f\)", $pkclmed,  $pkcltok[0], $pkcltok[3]);

        print "\t";
        printf ("%.2f \(%.2f-%.2f\)", $controlmed,  $controltok[0], $controltok[3]);
        print "\t";
        printf ("%.2f\n", $pkcladjpval->{$taxa}) ;

}





