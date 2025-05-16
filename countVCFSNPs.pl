open ($FH, "zcat $ARGV[0] |") or die ("$!: can't open file $infile");

my %count=();
while(my $line=<$FH>){
	next if($line=~/^#/);
	@ele=split(/\t/,$line);
	$count{$ele[0]}++;
}

foreach my $chr (sort keys %count){
	print($chr,"\t",$count{$chr},"\n");

}

