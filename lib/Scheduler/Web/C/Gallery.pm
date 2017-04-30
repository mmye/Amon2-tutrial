package Scheduler::Web::C::Gallery;

use strict;
use warnings;
use utf8;
use DDP;
use JSON;

sub load {
    my ($class, $c) = @_;

    my @rows = $c->db->search('images');
    unless(@rows) { 
        warn "fail to load images.";
        die;
    }
    my @images;
    for my $row (@rows) {
      p $row->path;
      if ( $row->path ne 'static/upload/' ) {
         push (@images, $row);
      }
    }
    ## return $c->render('gallery.tx', { images => \@images });
    return $c->render('gallery3.tx', { images => \@images });

}

1;
    
