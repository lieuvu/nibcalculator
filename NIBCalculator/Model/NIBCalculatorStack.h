//
//  NIBCalculatorStack.h
//  NIBCalculator
//
//  Created by Lieu Vu on 9/27/17.
//  Copyright © 2017 LV. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 `NIBCalculatorStack` acts as the stack data structure.
 */
@interface NIBCalculatorStack<ObjectType> : NSObject <NSCopying>

/// -----------------
/// @name Utitilities
/// -----------------

/**
 Push object to stack.
 
 @param object The object to push to the stack.
 */
- (void)push:(ObjectType)object;

/**
 Pop object to stack.
 
 @return Returns the object at the top of the stack.
 */
- (ObjectType _Nullable)pop;

/**
 Peek object of stack. It is used to look at the top of the stack
 without removing it from the stack.
 
 @return Returns the object at the top of the stack.
 */
- (ObjectType _Nullable)peek;

/**
 Clear the stack.
 */
- (void)clear;

@end

NS_ASSUME_NONNULL_END
