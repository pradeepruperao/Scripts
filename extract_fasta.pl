#usuage perl extract_fasta.pl [fasta_file] [list of IDs] > [output_file>]

use Bio::SeqIO;

open(DATA, $ARGV[1]);

while(<DATA>)
{
  chomp;
  $id{$_}=$_;
}
close(DATA);

$seqin = Bio::SeqIO->new(
                            -file => $ARGV[0],
                            -format => 'fasta',
                            );
                          
                            
while (my $inseq = $seqin->next_seq) {

    if(exists $id{$inseq->id}){
    print ">".$inseq->id."\n".$inseq->seq()."\n";}
}
