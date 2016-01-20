//
//  MDCDamerauLevenshteinDistanceTests.m
//  MDCDamerauLevenshtein
//
//  Created by Brian Ivan Gesiak on 5/19/14.
//
//

#import <XCTest/XCTest.h>
#import "MDCDamerauLevenshteinDistance.h"

@interface MDCDamerauLevenshteinDistanceTests : XCTestCase

@end

@implementation MDCDamerauLevenshteinDistanceTests

- (void)testDistanceWithNullStringsRaises {
    XCTAssertThrows(mdc_damerauLevenshteinDistance(nil, @"right"), @"Expected nil left string to raise");
    XCTAssertThrows(mdc_damerauLevenshteinDistance(@"left", nil), @"Expected nil right string to raise");
    XCTAssertThrows(mdc_damerauLevenshteinDistance(nil, nil), @"Expected nil strings to raise");
}

- (void)testDistanceBetweenEqualStringsIsZero {
    XCTAssertEqual(mdc_damerauLevenshteinDistance(@"Menlo", @"Menlo"), 0,
                   @"Expected distance between identical strings to be zero");
}

- (void)testDistanceBetweenStringsUsesEfficientTranspositions {
    XCTAssertEqual(mdc_damerauLevenshteinDistance(@"Menlo Prak", @"Melno Park"), 2,
                   @"Expected Damerau-Levenshtein to transpose 'ln' and 'ra' for a distance of 2");
}

- (void)testDistanceBetweenEmptyStringsIsZero {
    XCTAssertEqual(mdc_damerauLevenshteinDistance(@"", @""), 0,
                   @"Expected distance between two empty strings to be zero");
}

- (void)testDistanceBetweenAnyStringAndEmptyStringsIsLengthOfString {
    XCTAssertEqual(mdc_damerauLevenshteinDistance(@"", @"1 Infinite Loop"), 15,
                   @"Expected distance between string and empty string to be length of string");
}

- (void)testStringsWithSameWordsAtBeginning {
	XCTAssertEqual(mdc_damerauLevenshteinDistance(@"rogate sunday", @"sunday"), 7);
}

@end
