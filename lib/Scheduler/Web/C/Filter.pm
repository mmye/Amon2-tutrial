package Scheduler::Web::C::Filter;

use strict;
use warnings;
use utf8;
use DDP;
use Encode qw/ encode decode /;


sub load {
    my ( $class, $c ) = @_;
    $c->render('filter.tx')
}

sub filter {
    my ( $class, $c, $args ) = @_;
    warn '$class: ';
    p $class;
    warn '$c';
    p $c;
    warn '$args';
    p $args;
    my $file = $args->{base};
    open(my $fh, "<", $file) or die "Cannot open $file: $!\n";

    my $pattern = '\A\d+';
    my @filtered;
    while(<$fh>) {
  my $line = $_;
  chomp();
  if ($line =~ /$pattern/) {
           push(@filtered, $line);
  }
    }

    close($fh);
    return @filtered;

}


1;

