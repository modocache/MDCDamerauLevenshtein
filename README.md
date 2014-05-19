# MDCDamerauLevenshtein

[![Build Status](https://travis-ci.org/modocache/MDCDamerauLevenshtein.svg?branch=master)](https://travis-ci.org/modocache/MDCDamerauLevenshtein)

Categories to calculate the edit distance between `NSString` objects.

```objc
[@"Central Park" mdc_levenshteinDistanceTo:@"Centarl Prak"];         // => 4
[@"Central Park" mdc_damerauLevenshteinDistanceTo:@"Centarl Prak"];  // => 2
```

MDCDamerauLevenshtein includes two algorithms for calculating
the edit distance between NSString objects:

1. Levenshtein distance calculates the number of insertions,
  deletions, and substitions necessary in order to convert one
  string into the other.
2. Damerau-Levenshtein improves upon Levenshtein to include the
  transposition of two adjacent characters. Damerau states that
  some combination of the four operations make up for 80% of all
  human spelling errors.

Potential applications for this library:

- Don't just use `-[NSString compare:options:]` to filter search results,
 display terms with small edit distances.
- ...and many more!

## Other Implementations

- [koyachi/NSString-LevenshteinDistance](https://github.com/koyachi/NSString-LevenshteinDistance)
  also provides categories on `NSString`, but only computes Levenshtein distance, not
  Damerau-Levenshtein. Does not include unit tests.

