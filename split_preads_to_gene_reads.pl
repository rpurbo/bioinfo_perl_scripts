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

                        $j = 1;
                        for($i=0;$i<length($current_reads);$i=$i+500){
                                if(($i+500) > length($current_reads)){
                                        $seq = substr($current_reads,$i,length($current_reads) - $i);
                                        print $current_header . " " . $j . "\n";
                                        print $seq . "\n";
                                        last;
                                }else{
                                        $seq = substr($current_reads,$i,500);
                                        print $current_header . "." . $j . "\n";
                                        print $seq . "\n";

                                }

                                $j++;
                        }
                }

                $current_header = $header;
                $current_reads = "";
                                $current_reads = "";

        }else{
                $read = $buff;
                $current_reads .= $read;
        }
}


for($i=0;$i<length($current_reads);$i=$i+500){
        if(($i+500) > length($current_reads)){
                $seq = substr($current_reads,$i,length($current_reads) - $i);
                print $current_header . " " . $j . "\n";
                print $seq . "\n";
                last;
        }else{
                $seq = substr($current_reads,$i,500);
                print $current_header . "." . $j . "\n";
                print $seq . "\n";
        }
        $j++;
}
