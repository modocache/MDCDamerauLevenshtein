//
//  MDCDamerauLevenshteinDistance.m
//  MDCDamerauLevenshtein
//
//  Created by Brian Ivan Gesiak on 5/19/14.
//
//

#import "MDCDamerauLevenshteinDistance.h"
#import "MDCLevenshteinDistance.h"
#import "MDCDistanceMatrix.h"

#pragma mark - Public Interface

extern NSUInteger mdc_damerauLevenshteinDistance(NSString *left, NSString *right) {
    mdc_normalizeDistanceParameters(&left, &right);
    if ([right length] == 0) {
        return [left length];
    }
	return [[MDCDistanceMatrix alloc] initWithLeftString:left rightString:right].damerauLevenshteinDistance;
}
