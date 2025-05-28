#!/usr/bin/perl
use strict;
use warnings;

# Input files
my $allele_file   = "AlleleData.csv";
my $genotype_file = "GenotypeData.csv";
my $output_file   = "ConvertedGenotypeData.csv";

# Read allele information
my %allele_info;

open my $allele_fh, "<", $allele_file or die "Cannot open $allele_file: $!";
while (<$allele_fh>) {
    chomp;
    #print($_);
    my @cols = split /,/;
    my $marker = $cols[0];
    my $alleles = $cols[-1];
    #print($marker,"\t",$alleles,"\n");

    if ($alleles =~ /\[([A-Z])\/([A-Z])\]/i) {
	    #print("Inside oooooooooooooooooooooo \n");
        my ($ref, $alt) = ($1, $2);
        $allele_info{$marker} = { ref => $ref, alt => $alt };
	#print($marker,"\t",$ref,"\t",$alt,"\n");
    }
}
close $allele_fh;

# Open input and output files
open my $in_fh,  "<", $genotype_file or die "Cannot open $genotype_file: $!";
open my $out_fh, ">", $output_file   or die "Cannot write to $output_file: $!";

# Process header
my $header = <$in_fh>;
chomp($header);
my @header_cols = split /,/, $header;
print $out_fh "$header\n";

# Get marker indices (from column 3 onward)
my @marker_ids = @header_cols[2..$#header_cols];

# Process each genotype row
while (<$in_fh>) {
    chomp;
    my @row = split /,/;
    #print(scalar(@row)," Last element:",$row[$#row],"\n");

    # Keep Panel and Genotype columns (first two columns)
    my @output_row = @row[0, 1];

    # Process genotypes (from column 3 onward)
    for my $i (2 .. $#row) {
        my $marker = $marker_ids[$i - 2];
        my $genotype = $row[$i];
	#if($marker eq "SG9B_23202369"){}

        if (!defined $genotype || $genotype eq '' || $genotype eq '--' || $genotype eq 'NA') {
            push @output_row, '-';
	    #print("Genotyp is null  ----- $marker\n");
            next;
        }

        if (exists $allele_info{$marker}) {
            my ($ref, $alt) = @{$allele_info{$marker}}{qw(ref alt)};
            my @alleles = split /:/, $genotype;
	    #print($ref,"\t", $alt,"\n");

            if ($alleles[0] eq $ref && $alleles[1] eq $ref) {
                push @output_row, '0';
            } elsif ($alleles[0] eq $alt && $alleles[1] eq $alt) {
                push @output_row, '1';
            } elsif (
                ($alleles[0] eq $ref && $alleles[1] eq $alt) ||
                ($alleles[0] eq $alt && $alleles[1] eq $ref)
            ) {
                push @output_row, '2';
            } else {
                push @output_row, '-';  # Unrecognized/mismatched genotype
            }
        } else {
            push @output_row, '-';  # No allele data found
        }
    }
    #last;
    # Write the modified row to output file
    print $out_fh join(",", @output_row) . "\n";
    
}

close $in_fh;
close $out_fh;

print "Genotype data conversion completed. Output saved to $output_file\n";

