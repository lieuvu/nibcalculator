//
//  NIBCalculatorStack.m
//  NIBCalculator
//
//  Created by Lieu Vu on 9/27/17.
//  Copyright © 2017 LV. All rights reserved.
//

#import "NIBCalculatorStack.h"


/////////////////////////////////////////////////////////////////////////////
#pragma mark - Class Extension


NS_ASSUME_NONNULL_BEGIN

@interface NIBCalculatorStack ()

/** The stack. */
@property (readwrite, strong, nonatomic) NSMutableArray *stack;

@end

NS_ASSUME_NONNULL_END


/////////////////////////////////////////////////////////////////////////////
#pragma mark - Class Implementation


@implementation NIBCalculatorStack


/////////////////////////////////////////////////////////////////////////////
#pragma mark - Public Methods

#pragma mark Initializing A Stack

+ (instancetype)stack
{
    NIBCalculatorStack *stack = [[self alloc] init];
    
    if (stack) {
        stack.stack = [[NSMutableArray alloc] init];
    }
    
    return stack;
}

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        _stack = [[NSMutableArray alloc] init];
    }
    
    return self;
}

#pragma mark Utilities

- (void)push:(id)object
{
    [self.stack addObject:object];
}

- (id)pop
{
    id topOfStack = self.stack.lastObject;
    [self.stack removeLastObject];
    return topOfStack;
}

- (id)peek
{
    return self.stack.lastObject;
}

- (void)clear
{
    [self.stack removeAllObjects];
}


/////////////////////////////////////////////////////////////////////////////
#pragma mark - NSObject


- (NSString *)description
{
    NSMutableString *description = [NSMutableString stringWithString:@"NIBCalculatorStack: {\n"];
    for (id obj in self.stack) {
        [description appendString:[obj description]];
        [description appendString:@"\n"];
    }
    [description appendString:@"}"];
    
    return description;
}


/////////////////////////////////////////////////////////////////////////////
#pragma mark - NSCopying


- (id)copyWithZone:(NSZone *)zone
{
    NIBCalculatorStack *newStack = [[[self class] allocWithZone:zone] init];
    
    for (id obj in self.stack) {
        [newStack.stack addObject:obj];
    }
    
    return newStack;
}

@end
