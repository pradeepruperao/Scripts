#usuage perl fasta_length.pl <fasta_file> > <output_file>

use Bio::SeqIO;

$seqin = Bio::SeqIO->new(
                            -file => $ARGV[0],
                            -format => 'fasta',
                            );
                          
                            
while (my $inseq = $seqin->next_seq) {
    print $inseq->id."\t".$inseq->length()."\n";
}
