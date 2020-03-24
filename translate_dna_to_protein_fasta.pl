use lib "/usr/local/apps/bioperl-1.6.1/lib/perl5/";

$file = $ARGV[0];

my %tax;

use Bio::SearchIO; 
use Bio::Seq;

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
                        #print $current_reads . "\n";
                        $seq_obj = Bio::Seq->new(-seq => $current_reads, -alphabet => 'dna' );
			$rev_seq_obj = $seq_obj->revcom;
			#print $seq_obj->seq . "\n";
			print $current_header . " +1\n";		
      			$prot_obj = $seq_obj->translate(-frame => 0 , -codontable_id => 11);
			print $prot_obj->seq . "\n";
			print $current_header . " +2\n"; 
			$prot_obj = $seq_obj->translate(-frame => 1 , -codontable_id => 11);
                        print $prot_obj->seq . "\n";
			print $current_header . " +3\n"; 
			$prot_obj = $seq_obj->translate(-frame => 2 , -codontable_id => 11);
                        print $prot_obj->seq . "\n";
			
			print $current_header . " -1\n"; 
			$prot_obj = $rev_seq_obj->translate(-frame => 0 , -codontable_id => 11);
			print $prot_obj->seq . "\n";
			print $current_header . " -2\n";
			$prot_obj = $rev_seq_obj->translate(-frame => 1 , -codontable_id => 11);
			print $prot_obj->seq . "\n";
			$prot_obj = $rev_seq_obj->translate(-frame => 2 , -codontable_id => 11);
                        print $current_header . " -3\n";	
			print $prot_obj->seq . "\n";
	          }

                $current_header = $header;
                $current_reads = "";

        }else{
                $read = $buff;
                $current_reads .= $read;
        }
}

$seq_obj = Bio::Seq->new(-seq => $current_reads, -alphabet => 'dna' );
$rev_seq_obj = $seq_obj->revcom;

print $current_header . " +1\n";
$prot_obj = $seq_obj->translate(-frame => 0 , -codontable_id => 11);
print $prot_obj->seq . "\n";
print $current_header . " +2\n";
$prot_obj = $seq_obj->translate(-frame => 1 , -codontable_id => 11);
print $prot_obj->seq . "\n";
print $current_header . " +3\n";
$prot_obj = $seq_obj->translate(-frame => 2 , -codontable_id => 11);
print $prot_obj->seq . "\n";

print $current_header . " -1\n";
$prot_obj = $rev_seq_obj->translate(-frame => 0 , -codontable_id => 11);
print $prot_obj->seq . "\n";
$prot_obj = $rev_seq_obj->translate(-frame => 1 , -codontable_id => 11);
print $current_header . " -2\n";
print $prot_obj->seq . "\n";
$prot_obj = $rev_seq_obj->translate(-frame => 2 , -codontable_id => 11);
print $current_header . " -3\n";
print $prot_obj->seq . "\n";



