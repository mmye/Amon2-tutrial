package Scheduler;
use strict;
use warnings;
use utf8;
our $VERSION='0.01';
use 5.008001;
use Teng;
use Teng::Schema::Loader;

use parent qw/Amon2/;
use File::Spec;

# Enable project local mode.
#__PACKAGE__->make_local_context();

my $schema;
sub db {
    my $self = shift;
    if ( !defined $self->{db} ) {
        my $conf = $self->config->{DBI}
            or die "Missing configuration about DBI";
        my $dbh = $self->dbh;
        $self->{db} = Teng::Schema::Loader->load(
            namespace => 'Scheduler::DB',
            dbh       => $dbh,
            );
#        $c->{db} = Scheduler::DB->new(
#            schema       => $schema,
#            connect_info => [@$conf],
            # I suggest to enable following lines if you are using mysql.
            # on_connect_do => [
            #     'SET SESSION sql_mode=STRICT_TRANS_TABLES;',
            # ],
    }
    return $self->{db};
}

1;
__END__

=head1 NAME

Scheduler - Scheduler

=head1 DESCRIPTION

This is a main context class for Scheduler

=head1 AUTHOR

masato

