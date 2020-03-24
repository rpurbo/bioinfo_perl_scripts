#SEPARATE FASTA INTO SEVERAL SMALLER FILES FASTA @10000 reads

$file = $ARGV[0];
$fout = $ARGV[1];
$size = 5;

$current_header = "";
$current_reads = "";
my %db;

my $track = 0;
$id = 0;
$out = $fout . "." . $id;
open (OUT, ">".$out);

open (FILE, $file);
while($buff = <FILE>){
        chomp $buff;
        if(substr($buff,0,1) eq ">"){
                $header = $buff;

                if($current_reads ne "") {
                	$all = $current_header . "\n" . $current_reads . "\n";
			#$db{$current_header} = $all;
			print OUT $all;
			$track++;

			if($track % $size == 0  ){
         		       	close(OUT);
                		$id++;
                		$out = $fout . "." . $id;
                		open (OUT, ">".$out);

        		}	
		}

                $current_header = $header ;
                $current_reads = "";

        }else{
                $read = $buff;
                $current_reads .= $read;
        }
}

print OUT $current_header . "\n" . $current_reads . "\n";
close(OUT);
