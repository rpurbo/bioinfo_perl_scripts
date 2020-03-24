use Statistics::Test::WilcoxonRankSum;
use Statistics::Multtest qw(:all);
use Statistics::R ;

$SAM1 = "YFC";
$SAM2 = "OFC";
$file="species.count.relative.DNA.txt";
$comp1 = $SAM1;
$comp2 = $SAM2;

open(FILE,$file);
$header =<FILE>;
chomp $header;
@tok = split(/\t/,$header);

my %toSample;
for($i=1;$i<scalar(@tok);$i++){
	#print $i . "\t" . $tok[$i] . "\n";
	if($tok[$i] eq ""){
		next;
	}
	$sample = $tok[$i];
	$sample =~ m/^(.+?)(\d)$/g;
	$sample = $1;

	$toSample{$i} = $sample;
	
}

my %db;
my %tax_median;
while($buff=<FILE>){
	chomp $buff;
	@tok = split(/\t/,$buff);
	$taxa = $tok[0];
	#print $taxa . "\t";
	
	for($i=1;$i<scalar(@tok);$i++){

		push (@{$db{$toSample{$i}}{$taxa}}, $tok[$i]) ;

		#$db{$toSample{$i}}{$taxa} .= $tok[$i] . "," ;
		#print $toSample{$i} . "-" . $tok[$i] . ",";
	}
	#print "\n";

}
close(FILE);


my %clues;
my %alltaxa;
for $idx (keys %db){
	if($idx eq ""){
		next;
	}
	
	
	for $taxa (keys %{$db{$idx}}){
		@arr = @{$db{$idx}{$taxa}};
		@sorted = sort { $a <=> $b } (@arr);
		$median = $sorted[2];
		
		#print $idx . "\t" . $taxa . "\t";
                $clues{$taxa}{$idx} = join(",",@sorted);
		#print join(",",@sorted) ;
                #print "\t" . $median . "\n";

		$tax_median{$taxa}{$idx} = $median;
		$alltaxa{$taxa} = 1;
	}
}


my $R = Statistics::R->new() ;
$R->startR ;
my %pvals = ();
my %logfolds;
my %se1s;
my %se2s;

for $taxa (keys %alltaxa){
	$p1 = $clues{$taxa}{$comp1};
	$p2 = $clues{$taxa}{$comp2};
	$med1 = $tax_median{$taxa}{$comp1};
	$med2 = $tax_median{$taxa}{$comp2};
	
	$med1 += 1;
	$med2 += 1;
	
	$logfold = log($med2/$med1) / log(2);
	#$logfold = ($med2/$med1);
	$logfolds{$taxa} = $logfold;

        $p1str = "t0 = c(". $p1 . ")";
        $p2str = "t10 = c(". $p2 . ")";

        $R->send($p1str);
        $R->send($p2str);
        $R->send('df = data.frame(t0,t10)');
	
	$R->send('sqrt(var(t0,na.rm=TRUE)/length(na.omit(t0)))');
        $ret = $R->read ;
	$ret =~ m/\[.+\](.+)/g;
	$se1 = $1;
	$se1s{$taxa} = $se1;
	

        $R->send('sqrt(var(t10,na.rm=TRUE)/length(na.omit(t10)))');
        $ret = $R->read ;
	$ret =~ m/\[.+\](.+)/g;
	$se2 = $1;
	$se2s{$taxa} = $se2;

	#$R->send('wilcox.test(t0,t10) ');
	$R->send('t.test(t0,t10) ');
        $ret = $R->read ;
        $ret =~ m/p-value = (.+)\s/g;
        $pval = $1;

	$pvals->{$taxa} = $pval;
	#print $taxa . "\t" . $p1  . "\t" . $p2 . "\t" . $pval . "\n";


}


my %pval_adj = ();
$pval_adj = BH($pvals);

print "taxa\t" . $comp1 . " median\t".$comp1." rel. abundances\t" . $comp2 . " median\t".$comp2." rel. abundances\tLogFold\tp-val\tAdj. p-val\n"; 
for $taxa (keys %alltaxa){

	print $taxa . "\t" ; 
	print $tax_median{$taxa}{$comp1} . "\t"; 
	print $clues{$taxa}{$comp1} . "\t" ; 
	print $tax_median{$taxa}{$comp2} . "\t"; 
	print $clues{$taxa}{$comp2} . "\t" ; 
	print $logfolds{$taxa} . "\t" . $pvals->{$taxa} . "\t" . $pval_adj->{$taxa} . "\n";
	#print $logfolds{$taxa} . "\t" . $pvals->{$taxa} . "\t";
	#print $se1s{$taxa} . "\t"  . $se2s{$taxa}   ."\n" ;

}


$R->stopR() ;
