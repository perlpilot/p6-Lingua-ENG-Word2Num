use v6;
#use Grammar::Debugger;

grammar Lingua::ENG::Word2Num::Parser {

    token TOP {
        | <billions>        { make +$<billions>.made }
        | <millions>        { make +$<millions>.made }
        | <thousands>       { make +$<thousands>.made }
        | <hundreds>        { make +$<hundreds>.made }
        | <tens>            { make +$<tens>.made }
        | <number>          { make +$<number>.made }
        | 'zero'            { make 0 }
    }

    rule billions {
        [ <b=.millions> | <b=.hundreds> | <b=.tens> | <b=.number> ] 'billion' 
        [
            [ <o=.millions> | <o=.thousands> | <o=.hundreds> | <o=.tens> | <o=.number> ] 
        ]?
        { make +$<b>.made * 1_000_000_000 + +($<o>.?made // 0); }
    }

    rule millions {
        [ <m=.hundreds> | <m=.tens> | <m=.number> ] 'million' 
        [
            [ <o=.thousands> | <o=.hundreds> | <o=.tens> | <o=.number> ] 
        ]?
        { make +$<m>.made * 1_000_000 + +($<o>.?made // 0); }
    }

    rule thousands {
        [ <t=.hundreds> | <t=.tens> | <t=.number> ] 'thousand' 
        [
            [ <o=.hundreds> | <o=.tens> | <o=.number> ] 
        ]?
        { make +$<t>.made * 1000 + +($<o>.?made // 0) }
    }

    rule hundreds {
        <n=.number> 'hundred' 
        [
            [ <o=.tens> | <o=.number> ]  
        ]?
       { make +$<n>.made * 100 + +($<o>.?made // 0) }
    }

    token tens {
        <ty-s> [ [ '-' | \h+ ] <digits> ]?    { make +$<ty-s>.made + +($<digits>.?made // 0); }
    }

    token number {
        | $<digits>=[\d+]   { make +$<digits> }     # maybe?
        | <digits>          { make +$<digits>.made }
        | <teens>           { make +$<teens>.made }
    }

    token digits {
        | 'one'             { make 1 }
        | 'two'             { make 2 }
        | 'three'           { make 3 }
        | 'four'            { make 4 }
        | 'five'            { make 5 }
        | 'six'             { make 6 }
        | 'seven'           { make 7 }
        | 'eight'           { make 8 }
        | 'nine'            { make 9 }
    }

    token teens {
        | 'ten'             { make 10 }
        | 'eleven'          { make 11 }
        | 'twelve'          { make 12 }
        | 'thirteen'        { make 13 }
        | 'fourteen'        { make 14 }
        | 'fifteen'         { make 15 }
        | 'sixteen'         { make 16 }
        | 'seventeen'       { make 17 }
        | 'eighteen'        { make 18 }
        | 'nineteen'        { make 19 }
    }

    token ty-s {
        | 'twenty'          { make 20 }
        | 'thirty'          { make 30 }
        | 'forty'           { make 40 }
        | 'fifty'           { make 50 }
        | 'sixty'           { make 60 }
        | 'seventy'         { make 70 }
        | 'eighty'          { make 80 }
        | 'ninety'          { make 90 }
    }
}

sub w2n ($words) is export {
    my $p = Lingua::ENG::Word2Num::Parser.parse($words);
    return ?$p ?? $p.made !! Any;
}

=begin END
 
=head1 NAME
 
=head2 Lingua::ENG::Word2Num
 
=head1 VERSION
 
    version 0.01
  
=head1 SYNOPSIS
 
    use Lingua::ENG::Word2Num;
   
    my @wordy-numbers = "numbers.dat".IO.lines;
    for @wordy-numbers -> $wn {
        my $num = w2n( $wn );
        say "$wn == ", defined($num) ?? $num !! "(unknown)";
    }

       
=head1 DESCRIPTION
 
English word to number conversion.
  
Lingua::ENG::Word2Num is a module for converting text containing a number
representation in English back into a number. Converts whole numbers from 0 up
to 999999999.
