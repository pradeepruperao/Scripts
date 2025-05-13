
$file = $ARGV[0];

if ($file =~ /.gz$/) 
{
    open(F1, “gunzip -c $file |”) || die “cant open file to $file: $!”;
}
else
{
    open(F1, $file) || die “cant open $file: $!”;
}


while(<F1>)
{
    @arr[0] = ();
    if(/^#/)
    {
        print $_;
    }
    else
    {
        chomp;
        @arr = split "\t", $_;
        $arr[0] = (split /\_/, $arr[0])[0];
        $arr[0] =~ s/Ca//;
        $arr[2] = $arr[0]."_".$arr[1];
        $line = join "\t", @arr;
        print $line."\n";
    }
}
close(F1);

