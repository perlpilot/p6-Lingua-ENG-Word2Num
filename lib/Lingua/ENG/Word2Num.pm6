use v6;
#use Grammar::Debugger;

grammar Lingua::ENG::Word2Num::Parser {

    token TOP {
        | <millions>        { make +$<millions>.made }
        | <thousands>       { make +$<thousands>.made }
        | <hundreds>        { make +$<hundreds>.made }
        | <tens>            { make +$<tens>.made }
        | <number>          { make +$<number>.made }
        | 'zero'            { make 0 }
    }

    token millions {
        | <m=.hundreds> \h+ 'million' \h+ <thousands>       { make +$<m>.made * 1_000_000 + +$<thousands>.made; }
        | <m=.hundreds> \h+ 'million' \h+ <hundreds>        { make +$<m>.made * 1_000_000 + +$<hundreds>.made; }
        | <m=.hundreds> \h+ 'million' \h+ <tens>            { make +$<m>.made * 1_000_000 + +$<tens>.made; }
        | <m=.hundreds> \h+ 'million' \h+ <number>          { make +$<m>.made * 1_000_000 + +$<number>.made; }
        | <m=.hundreds> \h+ 'million'                       { make +$<m>.made * 1_000_000 }

        | <m=.tens> \h+ 'million' \h+ <thousands>           { make +$<m>.made * 1_000_000 + +$<thousands>.made; }
        | <m=.tens> \h+ 'million' \h+ <hundreds>            { make +$<m>.made * 1_000_000 + +$<hundreds>.made; }
        | <m=.tens> \h+ 'million' \h+ <tens>                { make +$<m>.made * 1_000_000 + +$<tens>.made; }
        | <m=.tens> \h+ 'million' \h+ <number>              { make +$<m>.made * 1_000_000 + +$<number>.made; }
        | <m=.tens> \h+ 'million'                           { make +$<m>.made * 1_000_000; }

        | <m=.number> \h+ 'million' \h+ <thousands>         { make +$<m>.made * 1_000_000 + +$<thousands>.made; }
        | <m=.number> \h+ 'million' \h+ <hundreds>          { make +$<m>.made * 1_000_000 + +$<hundreds>.made; }
        | <m=.number> \h+ 'million' \h+ <tens>              { make +$<m>.made * 1_000_000 + +$<tens>.made; }
        | <m=.number> \h+ 'million' \h+ <number>            { make +$<m>.made * 1_000_000 + +$<number>.made; }
        | <m=.number> \h+ 'million'                         { make +$<m>.made * 1_000_000; }
    }

    token thousands {
        | <t=.hundreds> \h+ 'thousand' \h+ <hundreds>       { make +$<t>.made * 1000 + +$<hundreds>.made }
        | <t=.hundreds> \h+ 'thousand' \h+ <tens>           { make +$<t>.made * 1000 + +$<tens>.made }
        | <t=.hundreds> \h+ 'thousand' \h+ <number>         { make +$<t>.made * 1000 + +$<number>.made }
        | <t=.hundreds> \h+ 'thousand'                      { make +$<t>.made * 1000 }
 
        | <t=.tens> \h+ 'thousand' \h+ <hundreds>           { make +$<t>.made * 1000 + +$<hundreds>.made }
        | <t=.tens> \h+ 'thousand' \h+ <tens>               { make +$<t>.made * 1000 + +$<tens>.made }
        | <t=.tens> \h+ 'thousand' \h+ <number>             { make +$<t>.made * 1000 + +$<number>.made }
        | <t=.tens> \h+ 'thousand'                          { make +$<t>.made * 1000 }
 
        | <t=.number> \h+ 'thousand' \h+ <hundreds>         { make +$<t>.made * 1000 + +$<hundreds>.made }
        | <t=.number> \h+ 'thousand' \h+ <tens>             { make +$<t>.made * 1000 + +$<tens>.made }
        | <t=.number> \h+ 'thousand' \h+ <number>           { make +$<t>.made * 1000 + +$<number>.made }
        | <t=.number> \h+ 'thousand'                        { make +$<t>.made * 1000 }
    }

    token hundreds {
        | <n=.number> \h+ 'hundred' \h+ <tens>              { make +$<n>.made * 100 + +$<tens>.made }
        | <n=.number> \h+ 'hundred' \h+ <number>            { make +$<n>.made * 100 + +$<number>.made }
        | <n=.number> \h+ 'hundred'                         { make +$<n>.made * 100 }
    }

    token tens {
        | <ty-s> '-' <number>  { make +$<ty-s>.made + +$<number>.made; }
        | <ty-s> \h+ <number>  { make +$<ty-s>.made + +$<number>.made; }
        | <ty-s>               { make +$<ty-s>.made; }
    }

    token number {
        | $<digits>=[\d+]   { make +$<digits> }
        | 'one'             { make 1 }
        | 'two'             { make 2 }
        | 'three'           { make 3 }
        | 'four'            { make 4 }
        | 'five'            { make 5 }
        | 'six'             { make 6 }
        | 'seven'           { make 7 }
        | 'eight'           { make 8 }
        | 'nine'            { make 9 }
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
