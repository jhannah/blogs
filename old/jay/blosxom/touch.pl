#!/usr/bin/perl

open (IN, "ls *.txt |");
while (<IN>) {
   chomp;
   next unless (/^\d{8}/);   # Only whack the filenames where the names are dates.
   $date = $_;
   $date =~ s/\..*//;
   $cmd = "touch -d '$date' $_\n";
   #print $cmd;
   `$cmd`;
}
close IN;

