#!usr/bin/perl
use strict;
use warnings;

my $in=shift;
my $out=shift || "stat.out.xls";

if(!$in){
	print "\n\n perl $0 task1.data tast1.stat.out.xls\n\n";
	exit 0;
}

my %hash;
open IN,$in;
while(<IN>){
	chomp;
	next if /^$/;
    if(exists $hash{$_}){
		$hash{$_}++;
	}else{
		$hash{$_}=1;
	}
}
close IN;

open O,">$out";
foreach my $row(sort {$hash{$a}<=>$hash{$b}} keys %hash){
	print O "$row\t$hash{$row}\n";
}
close O;
