use Statistics::Test::WilcoxonRankSum;
use Statistics::R ;
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


my $R = Statistics::R->new() ;
$R->startR ;

my %pkchpval= ();
my %pkchadjpval = ();

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

	$pkch_neg = 4 - $pkch;
	$control_neg = 4 - $control;

	$com = "tab <- (matrix(c(". $pkch . "," . $control . "," . $pkch_neg . "," . $control_neg ."), nrow=2,ncol=2))";
	$R->send($com);
	$R->send("fisher.test(tab)");

	$ret = $R->read ;
        $ret =~ m/p-value = (.+)\s/g;
        $pval = $1;

        $pkchpval->{$taxa} = $pval;


}

$pkchadjpval = BH($pkchpval);
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

	print $taxa . "\t" . $pkch . "\t" . $control . "\t" . $pkchpval->{$taxa} . "\n";
}



my %pkclpval= ();
my %pkcladjpval = ();

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

        $pkcl_neg = 4 - $pkcl;
        $control_neg = 4 - $control;

        $com = "tab <- (matrix(c(". $pkcl . "," . $control . "," . $pkcl_neg . "," . $control_neg ."), nrow=2,ncol=2))";
        $R->send($com);
        $R->send("fisher.test(tab)");

        $ret = $R->read ;
        $ret =~ m/p-value = (.+)\s/g;
        $pval = $1;

        $pkclpval->{$taxa} = $pval;


}

$pkcladjpval = BH($pkclpval);
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

        print $taxa . "\t" . $pkcl . "\t" . $control . "\t" . $pkclpval->{$taxa} . "\n";
}

