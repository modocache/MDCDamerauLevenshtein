//
//  MDCLevenshteinDistance.m
//  MDCDamerauLevenshtein
//
//  Created by Brian Ivan Gesiak on 5/19/14.
//
//

#import "MDCLevenshteinDistance.h"
#import "MDCDistanceMatrix.h"

#pragma mark - Public Interface

NSUInteger mdc_levenshteinDistance(NSString *left, NSString *right) {
    mdc_normalizeDistanceParameters(&left, &right);
    if ([right length] == 0) {
        return [left length];
    }
	return [[MDCDistanceMatrix alloc] initWithLeftString:left rightString:right].levenshteinDistance;
}

void mdc_normalizeDistanceParameters(NSString **left, NSString **right) {
    if (*left == nil || *right == nil) {
        [NSException raise:NSInvalidArgumentException
                    format:@"Cannot compute edit distance between strings: '%@' and '%@'",
         *left, *right];
    }

    if ([*left compare:*right] == NSOrderedDescending) {
        NSString *tmp = *left;
        *left = *right;
        *right = tmp;
    }
}
