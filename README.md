Lingua::ENG::Word2Num
=====================

Naïve implementation of the Perl 5 module Lingua::ENG::Word2Num

    use Lingua::ENG::Word2Num;

    my @wordy-numbers = "numbers.dat".IO.lines;
    for @wordy-numbers -> $wn {
        my $num = w2n( $wn );
        say "$wn == ", defined($num) ?? $num !! "(unknown)";
    }
                                                     
