//
//  NIBOperation.h
//  NIBCalculator
//
//  Created by Lieu Vu on 10/21/17.
//  Copyright © 2017 LV. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NIBConstants.h"

NS_ASSUME_NONNULL_BEGIN

/**
 `NIBOperator` is a class to wrap the operators of calculation and provide
 some utilities methods to query the type of operators or compare the priority
 of two operators.
 
 @note The class can not be instantiated and will generate an __error__ if doing
 so. The class includes only class methods.
 */
@interface NIBOperator : NSObject

/// ----------------
/// @name Properties
/// ----------------

/** The operation index. */
@property (readonly, assign, nonatomic) NSInteger idx;

/// -------------------------
/// @name Unavailable Methods
/// -------------------------

/**
The init method is unavailable.
*/
- (instancetype) init __attribute__((unavailable("use +operatorWithTag: method")));

/// --------------------
/// @name Initialization
/// --------------------

/**
 Create the operator with a tag.
 
 @param tag The tag of the operator.
 
 @return Returns the NIBOperator instance.
 */
+ (instancetype _Nullable)operatorWithTag:(NSInteger)tag;

/// ----------------
/// @name Uitilities
/// ----------------

/**
 Check if an operator is an opening parenthesis.
 
 @return Returns YES if the operator is a parenthesis, otherwise NO.
 */
- (BOOL)isOpeningParanthesis;

/**
 Check if an operation is a closing parenthesis.
 
 @return Returns YES if the operator is a closing parenthesis, otherwise NO.
 */
- (BOOL)isClosingParanthesis;

/**
 Check if an operation is an parenthesis.
 
 @return Returns YES if the operator is an parenthesis, otherwise NO.
 */
- (BOOL)isParanthesis;

/**
 Check if an operation is an unary operation.
 
 @return Returns YES if the operation is unary operation, otherwise NO.
 */
- (BOOL)isUnaryOperator;

/**
 Check if an operation is an unary operation.
 
 @return Returns YES if the operation is unary operation, otherwise NO.
 */
- (BOOL)isBinaryOperator;

/**
 Check if the priority of a binary operator is higher than another binary
 oprator.
 
 @param aOperator    The binary operator to check against to.
 
 @return Returns a @b NSComparisonResult value that indicates
 the operator priority ordering.
    @b NSOrderedAscending: the receiver has less aOperator in priority ordering.
    @b NSOrderedSame the receiver and aOperator are equivalent in priority.
    @b NSOrderedDescending if the receiver has higher priority than aOperation.
 */
- (NSComparisonResult)comparePriorityWithOperator:(NIBOperator *)aOperator;

@end

NS_ASSUME_NONNULL_END
