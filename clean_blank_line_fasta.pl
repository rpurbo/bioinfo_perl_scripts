$file=$ARGV[0];
open(FILE,$file);
while($buff = <FILE>){
	chomp $buff;
	if($buff ne ""){
		print $buff . "\n";
	}
}
close(FILE);
