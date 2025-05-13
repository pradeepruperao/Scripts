#usuage perl filter_fasta_by_length.pl <length> <fasta_file> > <output_fasta_file>

use Bio::SeqIO;

$len = $ARGV[0];

$seqin = Bio::SeqIO->new(
                            -file => $ARGV[1],
                            -format => 'fasta',
                            );
                          
                            
while (my $inseq = $seqin->next_seq) 
{
    $length = $inseq->length();
    if($length >= $len)
    {
        print ">".$inseq->id."\n".$inseq->seq()."\n";
    }
}
