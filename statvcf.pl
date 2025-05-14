#!/usr/bin/perl
use strict;
use warnings;

# Check if file is provided
if (@ARGV != 1) {
    die "Usage: $0 <vcf_file>\n";
}

my $vcf_file = $ARGV[0];
open my $fh, '<', $vcf_file or die "Cannot open VCF file: $!\n";

# Initialize hash to store counts
my %sv_counts;

# Read VCF file
while (<$fh>) {
    next if /^#/;  # Skip header lines
    my @fields = split /\t/;
    my $chrom = $fields[0];
    my $info  = $fields[7];
    
    # Identify structural variant type
    my $type = "";
    if ($info =~ /SVTYPE=([^;]+)/) {
        $type = $1;
    }
    
    # Increment the count for the corresponding type
    if ($type =~ /^(DEL|DUP|INV|BND|INS)$/) {
        $sv_counts{$chrom}{$type}++;
    }
}
close $fh;

# Print header
print "Chromosome\tDeletion\tDuplication\tInversion\tTranslocation\tInsertion\n";

# Print counts per chromosome
for my $chrom (sort keys %sv_counts) {
    print "$chrom\t" .
          ($sv_counts{$chrom}{'DEL'} // 0) . "\t" .
          ($sv_counts{$chrom}{'DUP'} // 0) . "\t" .
          ($sv_counts{$chrom}{'INV'} // 0) . "\t" .
          ($sv_counts{$chrom}{'BND'} // 0) . "\t" .
          ($sv_counts{$chrom}{'INS'} // 0) . "\n";
}

