#!usr/bin/perl
use strict;
use warnings;

my $in=shift;

if(!$in){
	print "\n\n perl $0 brackets.list \n\n";
	exit 0;
}

my %hash;
open IN,$in;
while(<IN>){
	chomp;
        my $type1=($_=~s/\(/\(/g);
        my $type2=($_=~s/\)/\)/g);
        
	my $type3=($_=~s/\[/\[/g);
        my $type4=($_=~s/\]/\]/g);
        
	my $type5=($_=~s/\{/\{/g);
        my $type6=($_=~s/\}/\}/g);
        
	if($type1 != $type2){
		print "() can not be properly closed in $_ \n";
	}
	if($type3 != $type4){
		print "[] can not be properly closed in $_ \n";
	}
	if($type5 != $type6){
		print "{} can not be properly closed in $_ \n";
	}
}
close IN;



