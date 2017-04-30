package Scheduler::DB::Schema;
use strict;
use warnings;
use utf8;

use Teng::Schema::Declare;
use Time::Piece;

base_row_class 'Scheduler::DB::Row';

table {
    name 'schedules';
    pk 'id';
    columns qw(id title body date);

    #inflate 'date' => sub {
    #   my $col_value = shift;
    #print "inflating col_value: $col_value\n";
    #  return Time::Piece->strptime($col_value, "%s");
#    };
#    deflate 'date' => sub {
#        my $col_value = shift;
#  #print "Deflating! col_value: $col_value\n";
#  if ($col_value) {
#      Time::Piece->strptime($col_value, '%Y-%m-%d')->epoch;
#        };
#    };
};

table {
    name 'images';
    pk   'id';
    columns qw(id path type);
};

table {
    name 'sourcetexts';
    pk   'id';
    columns qw( id name type body date owner);
};


1;
