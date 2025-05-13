 use Bio::SeqIO;

    $in  = Bio::SeqIO->new(-file => $ARGV[0] ,
                           -format => 'fastq');
    $out = Bio::SeqIO->new(-file => ">$ARGV[1]" ,
                           -format => 'fasta');

    while ( my $seq = $in->next_seq() ) {
        $out->write_seq($seq);
    } 
