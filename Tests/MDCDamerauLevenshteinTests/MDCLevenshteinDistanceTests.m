//
//  MDCLevenshteinDistanceTests.m
//  MDCDamerauLevenshtein
//
//  Created by Brian Ivan Gesiak on 5/19/14.
//
//

#import <XCTest/XCTest.h>
#import "MDCLevenshteinDistance.h"

@interface MDCLevenshteinDistanceTests : XCTestCase

@end

@implementation MDCLevenshteinDistanceTests

- (void)testDistanceWithNullStringsRaises {
    XCTAssertThrows(mdc_levenshteinDistance(nil, @"right"), @"Expected nil left string to raise");
    XCTAssertThrows(mdc_levenshteinDistance(@"left", nil), @"Expected nil right string to raise");
    XCTAssertThrows(mdc_levenshteinDistance(nil, nil), @"Expected nil strings to raise");
}

- (void)testDistanceBetweenEqualStringsIsZero {
    XCTAssertEqual(mdc_levenshteinDistance(@"Menlo", @"Menlo"), 0,
                   @"Expected distance between identical strings to be zero");
}

- (void)testDistanceBetweenSimilarStrings {
    XCTAssertEqual(mdc_levenshteinDistance(@"Menlo", @"Menloh"), 1,
                   @"Expected distance between similar strings to be one");
}

- (void)testDistanceBetweenDifferentStrings {
    XCTAssertEqual(mdc_levenshteinDistance(@"Menlo", @"Portland"), 7,
                   @"Expected distance between radically different strings to be a large number");
}

- (void)testDistanceBetweenStringsDoesNotUseEfficientTranspositions {
    XCTAssertEqual(mdc_levenshteinDistance(@"Menlo Park", @"Melno Park"), 2,
                   @"Expected Levenshtein to remove and insert 'n' for a distance of 2");
}

- (void)testDistanceBetweenEmptyStringsIsZero {
    XCTAssertEqual(mdc_levenshteinDistance(@"", @""), 0,
                   @"Expected distance between two empty strings to be zero");
}

- (void)testDistanceBetweenAnyStringAndEmptyStringsIsLengthOfString {
    XCTAssertEqual(mdc_levenshteinDistance(@"", @"1 Infinite Loop"), 15,
                   @"Expected distance between string and empty string to be length of string");
}

@end
