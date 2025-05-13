@files = glob "*.txt";
$count=0; @arr=();
open(DATA, "+>Compiled_raspberry.stats");
print DATA "File_name\tBases#\tReads#\t\% bases >=Q20\t\% bases >=Q30\tAverage_read_length\tRead_len_range\tQual_range\tPhred_range\tGC_content\n";
foreach $file (@files)
{
  open(F1, $file);
  while(<F1>)
  {
    chomp;
    if(/File name/)
    {$val = (split ":", $_)[1]; $val =~ s/\s+//g; $arr[$count][0]=$val; }
    elsif(/Total bases/)
    {$val = (split ":", $_)[1]; $val =~ s/\s+//g; $arr[$count][1]=$val; }
    elsif(/Total reads/)
    {$val = (split ":", $_)[1]; $val =~ s/\s+//g; $arr[$count][2]=$val; }
    elsif(/\>\=Q20/)
    {$val = (split ":", $_)[1]; $val =~ s/\s+//g; $arr[$count][3]=$val; }
    elsif(/\>\=Q30/)
    {$val = (split ":", $_)[1]; $val =~ s/\s+//g; $arr[$count][4]=$val; }
    elsif(/Average read/)
    {$val = (split ":", $_)[1]; $val =~ s/\s+//g; $arr[$count][5]=$val; }
    elsif(/Read length range/)
    {$val = (split ":", $_)[1]; $val =~ s/\s+//g; $arr[$count][6]=$val; }
    elsif(/Quality range/)
    {$val = (split ":", $_)[1]; $val =~ s/\s+//g; $arr[$count][7]=$val; }
    elsif(/Phred range/)
    {$val = (split ":", $_)[1]; $val =~ s/\s+//g; $arr[$count][8]=$val; }
    elsif(/G-C content/)
    {$val = (split ":", $_)[1]; $val =~ s/\s+//g; $arr[$count][9]=$val; }
    
  }
  close(F1);
  $count++;
}
for($i=0;$i<$count;$i++)
{
  for($j=0;$j<10;$j++)
  {
    print DATA $arr[$i][$j]."\t";
  }
  print DATA "\n";
}
close(DATA);