#Consolidate multiple SAM aligment files from partitioned-large-database (>4GB)

$file1 = $ARGV[0];
$file2 = $ARGV[1];

#$SCORE = 15;

my %db;
my %scores;
my %reads;
my %cumulative;
my %buffers;
my %heads;
my %tails;
my %all;


$header = "";
open(FILE,$file1);
while ($buff = <FILE>){
	if(substr($buff,0,1) eq "@"){
		chomp $buff;
		#$header .= $buff;
		$heads{$buff}++;	
		print $buff . "\n";
		next;
	}

	@token = split(/\t/, $buff);
	$name = $token[0];
	$flag = $token[1];
	$chr = $token[2];
	$qscore = int($token[4]);	
	$read = $token[9];
	$qual = $token[10];

	if(($flag & 2)){	#MAPPED IN PROPER PAIR
		#print $buff;
		if($flag & 64){
			$db{$name} = 1;
			$heads{$name} = $buff;
			$scores{$name} += $qscore;
		}elsif($flag & 128){
			$db{$name} = 1;
			$tails{$name} = $buff;
			$scores{$name} += $qscore;
		}
		
		$all{$name} = 1;
	}

}
close(FILE);



my %db2;
my %heads2;
my %tails2;
my %scores2;
open(FILE,$file2);
while ($buff = <FILE>){
	if(substr($buff,0,1) eq "@"){
		chomp $buff;
		if($heads{$buff} eq ""){
			print $buff . "\n";
		}
		$heads{$buff}++;
                next;
        }

        @token = split(/\t/, $buff);
        $name = $token[0];
        $flag = $token[1];
        $chr = $token[2];
	$qscore = int($token[4]);
        $read = $token[9];
        $qual = $token[10];
	
        if(($flag & 2)){        #MAPPED IN PROPER PAIR
   	        #print $buff;
                if($flag & 64){
                        $db2{$name} = 1;
                        $heads2{$name} = $buff;
			$scores2{$name} += $qscore;
                }elsif($flag & 128){
                        $db2{$name} = 1;
                        $tails2{$name} = $buff;
			$scores2{$name} += $qscore;	
                }

		$all{$name} = 1;
        }


}
close(FILE);

$LIMIT = 0;

for $name (keys %all){

	if($db{$name} == 1 && $db2{$name} != 1){
		$head = $heads{$name};
		$tail = $tails{$name};
		
		if($scores{$name} >= $LIMIT){
			print $head ;
			print $tail ;
			#print $scores{$name} . " 1\n";
		}

	}elsif($db{$name} != 1 && $db2{$name} == 1){
		$head = $heads2{$name};
                $tail = $tails2{$name};

                if($scores2{$name} >= $LIMIT){
                        print $head ;
                        print $tail ;
			#print $scores{$name} . " 2\n";
                }


	}elsif($db{$name} == 1 && $db2{$name} == 1){
		$hiscore = 0;	
		if($scores{$name} > $scores2{$name}){
			$hiscore = $scores{$name};
			$head = $heads{$name};
                	$tail = $tails{$name};	
		}else{
			$hiscore = $scores2{$name};
			$head = $heads2{$name};
                	$tail = $tails2{$name};
		}

		if($hiscore >= $LIMIT){
			print $head ;
			print $tail ;
			#print $scores{$name} . " 3\n";
		}

	}	





}






