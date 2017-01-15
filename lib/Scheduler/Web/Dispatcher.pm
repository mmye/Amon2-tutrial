package Scheduler::Web::Dispatcher;
use strict;
use warnings;
use utf8;
use Amon2::Web::Dispatcher::RouterBoom;

use Time::Piece; # (1)

get '/' => sub {
    my ($c) = @_;
    
    my @schedules = $c->db->search('schedules');
    return $c->render('index.tx', {schedules => \@schedules });
};

#登録ボタンの処理
post '/post' => sub {
    my ($c) = @_;

    my $title = $c->req->parameters->{title}; #
    my $date  = $c->req->parameters->{date};  # (2)

    my $date_epoch = Time::Piece->strptime($date, '%Y/%m/%d')->epoch; # (3)

    $c->db->insert(schedules => { #
        title => $title,          #
        date  => $date_epoch,     # (4)
    });                           #

    return $c->redirect('/');
};

#削除ボタンの処理
post '/schedules/:id/delete' => sub {
    my ($c, $args) = @_;
    my $id = $args->{id};

    $c->db->delete('schedules' => { id => $id });
    return $c->redirect('/');
};

get '/user' => sub {
    my ($c) = @_;

    my $name = $c->req->parameters->{name};
    my $favorite = $c->req->parameters->{favorite};
    
    return $c->render('/user');
};

1;
