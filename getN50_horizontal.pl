#/usr/bin/perl -w
#use strict;
$name= $ARGV[0] ;
my $sum = 0;
my ($len,$total)=(0,0);
my @x;
while(<>){
	if(/^[\>\@]/){
		if($len>0){
			$contigs++;
			$total+=$len;
			push @x,$len;
		}
		$len=0;
	}
	else{	
		s/\s//g;
		$len+=length($_);
	}#																				
}
																				

if ($len>0){
	$contigs++;
	$total+=$len;
	push @x,$len;
}

my $max = 0;
my $N50 = 0;
my $N90 = 0;

@x=sort{$b<=>$a} @x; 
my ($count,$half)=(0,0);
for (my $j=0;$j<@x;$j++){
	$count+=$x[$j];
	if (($count>=$total/2)&&($half==0)){
		#print "N50: $x[$j]\n";
		if($N50 == 0){
			$N50 = $x[$j];
		}

		$half=$x[$j]
	}elsif ($count>=$total*0.9){
		#print "N90: $x[$j]\n";
		if($N90 == 0){
                        $N90 = $x[$j];
                } 
		#exit;
	}

	if($x[$j] > $max){
		$max = $x[$j];
	}

}

print "#File\tContig\tAvgLength\tTotalBases\tMaxLength\tN50\tN90\n";
print $name . "\t";
print $contigs . "\t";
print int($total / $contigs) . "\t" ;
print  $total . "\t";
print $max . "\t";
print $N50 . "\t";
print $N90 . "\n";



