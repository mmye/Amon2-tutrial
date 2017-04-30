package Scheduler::Web;
use strict;
use warnings;
use utf8;
use parent qw/Scheduler Amon2::Web/;
use File::Spec;

# dispatcher
use Scheduler::Web::Dispatcher;
sub dispatch {
    return (Scheduler::Web::Dispatcher->dispatch($_[0]) or die "response is not generated");
}

# load plugins
__PACKAGE__->load_plugins(
    'Web::FillInFormLite',
    'Web::JSON',
    '+Scheduler::Web::Plugin::Session',
);

# setup view
use Scheduler::Web::View;
{
    sub create_view {
        my $view = Scheduler::Web::View->make_instance(__PACKAGE__);
        no warnings 'redefine';
        *Scheduler::Web::create_view = sub { $view }; # Class cache.
        $view
    }
}

# for your security
__PACKAGE__->add_trigger(
    BEFORE_DISPATCH => sub {
        my ( $c, $res ) = @_; # $B0z?t2x$7$$(B

	#$c->{stash} = +{
	#};

        #my $user_id = $c->session->get('user_id');
        #if ( $user_id ) {
        #    # $B%m%0%$%s%f!<%6!<8~$1$N2?$+(B
	#    my $user = $c->db->single(users => {id => $user_id});
	#    $c->{stash}{user} = $user;
        #}

    },
    AFTER_DISPATCH => sub {
        my ( $c, $res ) = @_;

        # http://blogs.msdn.com/b/ie/archive/2008/07/02/ie8-security-part-v-comprehensive-protection.aspx
        $res->header( 'X-Content-Type-Options' => 'nosniff' );

        # http://blog.mozilla.com/security/2010/09/08/x-frame-options/
        $res->header( 'X-Frame-Options' => 'DENY' );

        # Cache control.
        $res->header( 'Cache-Control' => 'private' );
    },
);

1;
