
#usage perl script.pl start_pos end_pos


$outdir = "vcf_".$ARGV[0]."_".$ARGV[1];
mkdir $outdir;
@files=glob("*.vcf");

foreach $file (@files)
{
  open(F1, $file);
  $outfile = $ARGV[0]."_".$ARGV[1]."_".$file;
  open(F2, "+>$outdir/$outfile");
  while(<F1>)
  {
    if(/^#/)
    { print F2 $_; }
    else
    {
      $pos = (split /\t/, $_)[1];
      if($pos >= $ARGV[0] && $pos <= $ARGV[1])
      {
	print F2 $_;
      }
    }
  }
  close(F2);
  close(F1);
}
