//
//  MDCDistanceMatrix.m
//  MDCDamerauLevenshtein
//
//  Created by Brian Ivan Gesiak on 5/19/14.
//
//

#import "MDCDistanceMatrix.h"
#include <valarray>
#include <numeric>

#pragma mark - Public Interface

@interface MDCDistanceMatrix ()

@property (nonatomic, copy) NSString *leftString;
@property (nonatomic, copy) NSString *rightString;
@property (nonatomic, readonly) NSUInteger width;
@property (nonatomic, readonly) NSUInteger height;

@end

@implementation MDCDistanceMatrix

- (instancetype)initWithLeftString:(NSString*)left rightString:(NSString*)rightString {
	self = [super init];
	if (self) {
		_leftString = [left copy];
		_rightString = [rightString copy];
		_height = left.length+1;
		_width = rightString.length+1;
	}
	return self;
}

- (NSUInteger)levenshteinDistance {
	using namespace std;

	valarray<NSUInteger> matrix = [self createMatrix];
	
	for (NSUInteger y = 1; y < _height; ++y) {
		for (NSUInteger x = 1; x < _width; ++x) {
			// Each element in the matrix corresponds to the distance between
			// the two strings. For example, with "car" and "boat", the matrix
			// for the first characters of each would look like this:
			//
			//     0 c
			//     b 0
			//
			// The distance it would take to turn "c" into "b" via deletion is
			// the distance it would take to turn "b" into "bc" (1 by insertion),
			// plus one to delete the extra character.
			NSUInteger deletion = matrix[(y-1)*_width + x] + 1;
			
			// The distance it would take to turn "c" into "b" via insertion is
			// the cost of turning "c" into "" (1 by deletion), plus one.
			NSUInteger insertion = matrix[y*_width + x-1] + 1;
			
			// If the two characters are the same, there is no substituion cost,
			// so the distance is equivalent to the distance between the two previous
			// strings (the upper-left element in the matrix).
			NSUInteger substitution = matrix[(y-1)*_width + x-1];
			
			// But if they're different, the distance is the previous distance plus one.
			// The matrix is padded with row and column indices, so we must decrement
			// x and y when accessing characters in the string.
			if (![self sameCharacterAtLeftIndex:y-1 rightIndex:x-1]) {
				++substitution;
			}

			// We're interested in the most efficient edit distance, so use the minimum
			// of the three calculated costs.
			matrix[y*_width + x] = MIN(MIN(insertion, deletion), substitution);
		}
	}
	return matrix[(_height-1)*_width + (_width-1)];
}

- (NSUInteger)damerauLevenshteinDistance {
	using namespace std;
	
	valarray<NSUInteger> matrix = [self createMatrix];

	for (NSUInteger y = 1; y < _height; ++y) {
		for (NSUInteger x = 1; x < _width; ++x) {
			// Calculation of deletion, insertion, and substituion costs is
			// identical to the Levenshtein algorithm.
			NSUInteger cost = [self sameCharacterAtLeftIndex:y-1 rightIndex:x-1] ? 0 : 1;
			NSUInteger deletion = matrix[(y-1)*_width + x] + 1;
			NSUInteger insertion = matrix[y*_width + x-1] + 1;
			NSUInteger substitution = matrix[(y-1)*_width + x-1] + cost;
			
			// Damerau also accounts for transposition of adjacent characters.
			//
			// Check if both:
			//   a) the current left chatacter is the same as the previous right character, and
			//   b) the previous left character is the same as the current right character
			//
			// If so, we can swap the two. Note that if the four characters were the all
			// the same in the first place (i.e.: the "ll" in "hello" and "hello"),
			// we don't want to increment the edit distance; hence we add `cost`, not 1.
			NSUInteger transposition = NSUIntegerMax;
			if (x > 1 && y > 1 && [self sameCharacterAtLeftIndex:y-1 rightIndex:x-2] &&
				[self sameCharacterAtLeftIndex:y-2 rightIndex:x-1]) {
				transposition = matrix[(y-2)*_width + x-2] + cost;
			}
			matrix[y*_width + x] = MIN(MIN(MIN(insertion, deletion), substitution), transposition);
		}
	}
	return matrix[(_height-1)*_width + (_width-1)];
}

- (std::valarray<NSUInteger>)createMatrix {
	using namespace std;

	valarray<NSUInteger> matrix(_width*_height);
	valarray<size_t> leftIndexes(_height-1);
	valarray<size_t> rightIndexes(_width-1);
	iota(begin(leftIndexes), end(leftIndexes), 1);
	iota(begin(rightIndexes), end(rightIndexes), 1);
	matrix[leftIndexes*_width] = rightIndexes;
	matrix[rightIndexes] = rightIndexes;
	return matrix;
}

- (BOOL)sameCharacterAtLeftIndex:(NSUInteger)leftIndex rightIndex:(NSUInteger)rightIndex {
	return [@([self.leftString characterAtIndex:leftIndex])
			compare:@([self.rightString characterAtIndex:rightIndex])] == NSOrderedSame;
}

@end
