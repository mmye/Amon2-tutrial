package Scheduler::Web::C::Markdown;

use strict;
use warnings;

use Encode 'encode_utf8';
use Text::Xslate qw/ mark_raw /;
use Text::Markdown;
use Text::Xatena;
use Pod::Simple::XHTML;
use DDP;

my $converters = {
    markdown => sub {
        my $text = shift;
        return (Text::Markdown::markdown($text));
    },
    xatena => sub {
        my $text = shift;
        return Text::Xatena->new->format($text);
    },
    pod => sub {
        my $text = shift;
        my $parser = Pod::Simple::XHTML->new;
        $parser->html_header('');
        $parser->html_footer('');
        $parser->output_string(\my $html);
        $parser->parse_string_document($text);
        return ($html);
    },
};

sub markdown_form {
    my ( $class, $c ) = @_;
    #p $class
    p $c;
    return $c->render('markdown.tx');
};

sub preview {
    my ( $class, $c ) = @_;
    my $converter = $converters->{$c->req->param('format')};
    my $html = $converter ? $converter->($c->req->param('text')) : '';
    return $c->create_response(
        200,
        ['Content-Type' => 'text/plain'],
        [encode_utf8($html)]
    );
};

1;
