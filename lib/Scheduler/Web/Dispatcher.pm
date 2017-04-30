package Scheduler::Web::Dispatcher;
use Amon2::Web::Dispatcher::RouterBoom;
use Scheduler::DB;
use Module::Find;
useall 'Scheduler::Web::C';
base 'Scheduler::Web::C';

## Routing
post '/upload'    => 'Root#upload';   # ajax file upload
get '/search'     => 'Root#search';   # Search blog entries
get '/gallery'    => 'Gallery#load';  # picture gallery
get '/filter'     => 'Filter#load';   # text filter app
get '/admin'      => 'Root#admin';    # entry control
get '/new_entry'  => 'Root#new_entry';# writing page

## Function test page
get '/ajax_test1' => 'Test#test1';
get '/ajax_test2' => 'Test#test2';
get '/ajax_test3' => 'Test#test3';
get '/ajax_test4' => 'Test#test4';

use utf8;
use warnings;
use strict;
use File::Copy;
use File::Spec;
use Time::Piece;
use File::Basename;
use Digest::MD5 qw/md5_hex/; # image file name
use Data::Printer;

get '/' => sub {
    my ($c) = @_;

    # HTTP::Session2::ClientStore2;

    # 1. ログインIDとパスワードを受け取る
    # 2. ログインIDとパスワードが正しいか確認
    # 3. 正しければセッションにIDを持たせる
    #$c->session->set('user_id', 123);

    my $itr = $c->db->search('images');
    my @img_path;
    while( my $row = $itr->next ) {
        push( @img_path, $row->path);
    }

    ## Collect all entries
    my @schedules = $c->db->search('schedules',{}, { order_by => 'date DESC'});

    ## Get today's date str: yyyy/mm/dd
    my $localtime = localtime;
    my $today = $localtime->strftime("%Y/%m/%d");

    return $c->render('index.tx', {
       schedules => \@schedules,
       today     => \$today,
       images    => \@img_path
    });
};

## for jQuery modal window practice
get '/modalwindow' => sub{
    my ($c) = @_;

    return $c->render('modalwindow.tx');
};

## for bootstrap pulldown menu & select box
get '/purchase' => sub {
    my ($c) = @_;

    return $c->render('purchase.tx');
};

# Profile
get '/user' => sub {
    my ($c) = @_;

    # My profile
    my $profile = {
        name          => 'm.maeyama',
        age           => '31',
        sex           => 'male',
        favorite_food => 'sushi',
    };
    return $c->render('user.tx', {schedules => $profile});
};

# Posting a new entry
post '/post' => sub {
    my ($c) = @_;

    my $fn;
    my $dir = 'static/upload';

    ## Upload image to server storage
    my $image = $c->req->upload('upfile');

    if($image) {
        die if $image->size > 5242880; #filesize less than 5MB OK

        my $imagedata = do {
            open my $fh, '<', $image->path or die $!;
            local $/; <$fh>;
        };

        my $ext = '.'. Scheduler::Web::C::Util::valid_type($image->content_type);

        if ($ext) {
            my $hash = Digest::MD5::md5_hex($imagedata);
            $fn = "$hash"."$ext";
            my $dst = File::Spec->catfile($c->base_dir, $dir, "$hash$ext");
            my $src = $image->tempname;
            copy $src, $dst;
            }
        }

## Insert entry to DB
    my $title     = $c->req->parameters->{title};
    my $localtime = localtime;
    my $date      = $localtime->strftime("%Y/%m/%d");
    my $body      = $c->req->parameters->{body};
    my $row       = $c->db->insert(schedules => {
                        title => $title,
                        date  => $date,
                        body  => $body,
                    });

## Insert elements to img DB
    my $id = $row->id;

    if ($id) {
        my $path = $dir."/".$fn;
        my $imgpaths = $c->db->insert(images => {
            id   => $id,
            path => $path,
        });
    } else {
    }

    return $c->redirect('/');
};

## Deleting entries by id
post '/schedules/:id/delete' => sub {
    my ($c, $args) = @_;
    my $id = $args->{id};

    #Delete text and img
    $c->db->delete('schedules' => { id => $id });
    $c->db->delete('images'    => { id => $id });

    return $c->redirect('/');
};

# Download images
get '/schedules/:id/download' => sub {
    my ($c, $args) = @_;
    my $id = $args->{id};
    my $img = $c->db->single('images', {id => $id});
    my $filepath = $img->path;

    if ($filepath) { download_file($c, $args, $filepath) }

    return $c->redirect("/schedules/$id/edit");
};

# Generating edit page (method: GET)
get '/schedules/:id/edit' => sub {
    my ($c, $args) = @_;

    my $id = $args->{id};
    my $row = $c->db->single('schedules', {id => $id});
    my $img = $c->db->single('images', {id => $id});

    ## Get basename for download link
    ## Conditinal logic: image availability
    if ($img) {
        my $basename = '/static/upload/' . basename($img->path);
        return $c->render('edit.tx', {
            schedules => $row,
            images    => $img,
            download  => $basename,
            });
    } else {
        return $c->render('edit.tx', {
            schedules => $row,
            images    => $img,
            }) ;
    }
};

# Update entry (Method: POST)
post '/schedules/:id/update' => sub {
    my ($c, $args) = @_;
    my $id   = $args->{id};
    my $body = $c->req->parameters->{body};## this fails to get textarea strings.
    $c->db->update('schedules',{ 'body' => $body }, { 'id' => $id });

    return $c->redirect('/');
};

1;
