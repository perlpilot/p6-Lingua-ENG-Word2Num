use v6;

use Test;
use Lingua::ENG::Word2Num;

plan *;

for dir('t') -> $t {
    next unless $t ~~ / '.test' $ /;
    my @tests = lines($t.IO).grep({$_ !~~ /^'#'/}).map({ [ .split('|') ] });
    for @tests -> $t {
        my ($input, $expected, $desc) = @($t);
        $desc //= $input;
        my $actual = w2n($input);
        is $actual, $expected, $desc;
    }
}

done;
