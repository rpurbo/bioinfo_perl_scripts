
$file = $ARGV[0];

$current_header = "";
$current_reads = "";
my %db;

open (FILE, $file);
while($buff = <FILE>){
        chomp $buff;
        if(substr($buff,0,1) eq ">"){
                $header = $buff;

                if($current_reads ne "") {
			my @seqs;
			$seqstart = 0;
			$cnt = 1;
			$seq = $current_reads;
			#print $seq . "\n" ;
			while($seq =~ m/(N+)/gi){
				$start = $-[1];
				$stop = $+[1];
				$len = $stop - $start;
		
				$subseq = substr($seq, $seqstart, ($start - $seqstart) );
				#print ">" . $contig . "_" . $seqstart . "_" . $start . "_Gap" . $cnt . "_" . $len . "\n";		
				#print ">" . $subseq . "\n";
				push(@seqs,$subseq);				

				$seqstart = $stop;
				$cnt++;
			}
			$subseq = substr($seq, $seqstart, (length($seq)-$seqstart));
			push(@seqs, $subseq);
			#print ">" . $subseq . "\n";
			
			$j = 1;
			for $seq (@seqs){
				if(length($seq) < 1500){
					print $current_header . " " . $j . "\n";
					print $seq . "\n";
					$j++;
				}else{

					for($i=0;$i<length($seq);$i=$i+1000){
						if(($i+1500) > length($seq)){
							$subseq = substr($seq,$i,length($seq) - $i);
							print $current_header . " " . $j . "\n";
							print $subseq . "\n";
							last;
						}else{
							$subseq = substr($seq,$i,1500);
							print $current_header . " " . $j . "\n";
                         		        	print $subseq . "\n";
					
						}

						$j++;
					}
				}
				$j++;
			#last;
			}
		}
	
                $current_header = $header;
                $current_reads = "";

        }else{
                $read = $buff;
                $current_reads .= $read;
        }
}

 $all = $current_header . "\n" . $current_reads . "\n";
 $db{$current_header} = $all;





