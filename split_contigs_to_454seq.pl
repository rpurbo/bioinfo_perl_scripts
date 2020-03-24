
$file = $ARGV[0];
$size = 500;

$current_header = "";
$current_reads = "";
my %db;

open (FILE, $file);
while($buff = <FILE>){
        chomp $buff;
        if(substr($buff,0,1) eq ">"){
                $header = $buff;

                if($current_reads ne "") {
                	#$all = $current_header . "\n" . $current_reads . "\n";
			#$db{$current_header} = $all;
			
			$j = 1;
			for($i=0;$i<length($current_reads);$i=$i+$size){
				if(($i+$size) > length($current_reads)){
					$seq = substr($current_reads,$i,length($current_reads) - $i);
					print $current_header . "_" . $i . "-" . ($i+length($current_reads) - $i) . "\n";
					print $seq . "\n";
					last;
				}else{
					$seq = substr($current_reads,$i,$size);
					print $current_header . "_" . $i . "-" . ($i+$size) . "\n";
                                        print $seq . "\n";
					
				}

				$j++;
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





