open(IN, "gunzip -dc $ARGV[0] |") or die "gunzip $file: $!";



while(<IN>)
{
    $a = $b =$c =$n = 0;
    if(!/^#/)
    {
        chomp;
        @arr = ();
        @arr = split "\t", $_;
        for($i = 9; $i<= $#arr; $i++)
        {
            $call = (split /:/, $arr[$i])[0];
            #print $call."\n";
            if($call eq "0/0" || $call eq "0|0")
            {
                $a++;
            }
            elsif($call eq "1/1" || $call eq "1|1")
            {
                $b++;
            }
            elsif($call eq "0/1" || $call eq "0|1" || $call eq "1/0" || $call eq "1|0")
            {
                $c++;
            }
            elsif($call eq "./." || $call eq ".|.")
            {
                $n++;
            }
            else
            {
                print "ERROR at ".$arr[0]."_".$arr[1]."\n";
                exit;
            }
        }
        $total = ($a +$b +$c +$n);
        $het = $c/$total;
        if($het >= 0.2)
        {print $arr[0]."\t".$arr[1]."\t".$het."\t".$c."\t".$total."\n";}
    }
}
close(IN);
