#!usr/bin/perl
use strict;
use warnings;

my $in=shift;
my $out=shift || "stat.overlaps.with.xls";
my $top=shift || "10";

if(!$in){
	print "\n\n perl $0  hg19.trf.bed  stat.out.xls\n\n";
	exit 0;
}


my %hash;

open IN,$in;
while(<IN>){
	chomp;
        my @A=(split /\s+/,$_);
        my $loc="$A[0]:$A[1]-$A[2]";
	   $hash{$loc}=1;
   }
   close IN;

my %stat;
my %detail;
foreach my $chr(keys %hash){
	my $tem=(split /:/,$chr)[1];
	my ($star,$end)=(split /-/,$tem);

	foreach my $chr2(keys %hash){
		if($chr ne $chr2){
			my $tem2=(split /:/,$chr2)[1];
			my ($star2,$end2)=(split /-/,$tem2);
                        my $nu1=$star2 - $end;
	 		my $nu2=$star2 - $star;
			my $nu3=$end2 - $end;
			my $nu4=$end2 - $star;
	                if(($nu1 < 0 && $nu2 >0) || ($nu3 < 0 && $nu4 >0) || ($nu3>0 && $nu1<0) || ($nu2<0 && $nu4>0) ){
				$stat{$chr}++;
				if(exists $detail{$chr}){
					$detail{$chr}.=";$chr2";
				}else{
					$detail{$chr}=$chr2;
				}
			}
		}
	}
}

my $num=0;
open O,">$out";
foreach my $k(sort {$stat{$b}<=>$stat{$a}} keys %stat){
        $num++;
        my $c=$k;
	   $c=~s/:/\t/g;
	   $c=~s/-/\t/g;

	   if($num<$top || $num==$top){
		print O "$c\t$stat{$k}\t$detail{$k}\n";
		}
}
close O;



                                           
                                



						

