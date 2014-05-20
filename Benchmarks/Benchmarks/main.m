//
//  main.m
//  Benchmarks
//
//  Created by Brian Ivan Gesiak on 5/20/14.
//
//

#import <Foundation/Foundation.h>
#import <MDCDamerauLevenshtein/MDCDamerauLevenshtein.h>
#import <NSString+LevenshteinDistance/NSString+LevenshteinDistance.h>

// Declare internal GCD benchmarking function.
// See: http://nshipster.com/benchmarking/
extern uint64_t dispatch_benchmark(size_t count, void (^block)(void));

static NSString * const LevenshteinDescription =
@"In information theory and computer science, the Levenshtein distance is a string metric for "
@"measuring the difference between two sequences. Informally, the Levenshtein distance between "
@"two words is the minimum number of single-character edits (i.e. insertions, deletions or "
@"substitutions) required to change one word into the other. It is named after Vladimir "
@"Levenshtein, who considered this distance in 1965";

static NSString * const DamerauLevenshteinDescription =
@"In information theory and computer science, the Damerau–Levenshtein distance (named after "
@"Frederick J. Damerau and Vladimir I. Levenshtein) is a distance (string metric) between two "
@"strings, i.e., finite sequence of symbols, given by counting the minimum number of operations "
@"needed to transform one string into the other, where an operation is defined as an insertion, "
@"deletion, or substitution of a single character, or a transposition of two adjacent characters. "
@"In his seminal paper, Damerau not only distinguished these four edit operations but also stated "
@"that they correspond to more than 80% of all human misspellings. Damerau's paper considered "
@"only misspellings that could be corrected with at most one edit operation.";

void profile_mdc_levenshteinDistanceTo(NSString *left, NSString *right, size_t iterations) {
    uint64_t nanoseconds = dispatch_benchmark(iterations, ^{
        [left mdc_levenshteinDistanceTo:right];
    });

    NSLog(@"-[NSString mdc_levenshteinDistanceTo:] Average runtime: %llu ns, distance: %lu",
          nanoseconds, [left mdc_levenshteinDistanceTo:right]);
}

void profile_koyachi_levenshteinDistanceTo(NSString *left, NSString *right, size_t iterations) {
    uint64_t nanoseconds = dispatch_benchmark(iterations, ^{
        [left levenshteinDistanceTo:right];
    });
    NSLog(@"-[NSString levenshteinDistanceTo:] Average runtime: %llu ns, distance: %lu",
          nanoseconds, [left levenshteinDistanceTo:right]);
}

int main(int argc, const char **argv) {
    @autoreleasepool {
        NSLog(@"*** Profiling with strings of average length...");
        profile_mdc_levenshteinDistanceTo(@"sitting", @"kitten", 100000);
        profile_koyachi_levenshteinDistanceTo(@"sitting", @"kitten", 100000);

        NSLog(@"*** Profiling with large strings...");
        profile_mdc_levenshteinDistanceTo(LevenshteinDescription, DamerauLevenshteinDescription, 100);
        profile_koyachi_levenshteinDistanceTo(LevenshteinDescription, DamerauLevenshteinDescription, 100);
    }
    return 0;
}

