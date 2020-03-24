$file = $ARGV[0];

open (FILE, $file);
while($buff = <FILE>){
	$cnt++;
}
close (FILE);



print STDERR "Count: " . $cnt . "\n";


sub trim($)
{
	my $string = shift;
	$string =~ s/^\s+//;
	$string =~ s/\s+$//;
	return $string;
}

