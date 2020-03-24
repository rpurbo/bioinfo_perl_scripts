$file = $ARGV[0];
open(FILE,$file);
while($buff = <FILE>){
    if(substr($buff,0,1) eq "@"){
        $buff =~ s/\-//g;
	@token = split(/\:/,$buff);
        
	@nametok = split(/_/,$token[0]);
        $header = $nametok[0] . "_" . $nametok[1]  . ":" . $token[1] . ":" . $token[2] . ":" . $token[3] . ":" . $token[4] . "";
        print $header; 
    }else{
        print $buff;
    }

}
close(FILE);
