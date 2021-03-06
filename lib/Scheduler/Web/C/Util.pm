package Scheduler::Web::C::Util;

use strict;
use warnings;
use utf8;
use DDP;

sub valid_type {
    my $type = shift;
    warn "type--------->";
    p $type;
    my %valid_types = (
	    'image/gif'          => 'gif',
	    'image/jpeg'         => 'jpg',
	    'image/bmp'          => 'bmp',
            'image/png'          => 'png',
	    'text/plain'         => 'txt',
	    'application/pdf'    => 'pdf',
	    'application/msword' => 'docx'
	    );
    warn "return type---->";
    return $valid_types{$type};
}

sub create_filename {
   my $ext = shift;

   my $date = localtime;
   my $rand_num = sprintf "%05s",int(rand 100000);

   my $filename = 'img_'.$date->datetime(
	   date => '',
	   time => '', 
	   T => ''
	   );
   return $filename  .= '_'.$rand_num.'.'.$ext;
}

#sub download_file {
#    my ($class, $c, $args) = @_;

    ## return $c->res_403 unless $c; ## unless $c->stash->{signed_member};
    ## return $c->res_404 unless $c->config->{image_sizes}->{$args->{size}};
 
    ## Need file path to '{hash}'??
    ##my $image = $c->service->fetch_image($args->{path}) or return $c->res_404;
    ## return $c->res_403 unless $image->member_id != $c->stash->{signed_member};
 
    ## unless ( -f $image->path($args->{size}) ) {
    ##    $image->scale($args->{size});
    ## }
 
    ##my $filename = $image->filename_encoded;
    ##my $res = $c->context->create_response(
    ##    200,
    #    [
    #        'Content-Disposition' => qq/attachment; filename="$filename"/,
    #        'Content-Type'        => 'application/octet-stream',
 
            # これはキャッシュさせたくない
   #         'Cache-Control' => 'private, no-store, no-cache, must-revalidate',
   #     ],
   #     [$image->file($args->{size})->slurp],
   # );
   # return $res;
#}

1;
