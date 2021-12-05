//
//  MDCDistanceMatrix.h
//  MDCDamerauLevenshtein
//
//  Created by Brian Ivan Gesiak on 5/19/14.
//
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MDCDistanceMatrix : NSObject

- (instancetype)initWithLeftString:(NSString*)left rightString:(NSString*)rightString;

@property (nonatomic, readonly) NSUInteger levenshteinDistance;
@property (nonatomic, readonly) NSUInteger damerauLevenshteinDistance;

@end

NS_ASSUME_NONNULL_END
