//
//  NIBCalculatorBrain.m
//  NIBCalculator
//
//  Created by Lieu Vu on 8/17/17.
//  Copyright © 2017 LV. All rights reserved.
//

#import "NIBCalculatorBrain.h"
#import "NIBCalculatorStack.h"
#import "NIBOperator.h"


/////////////////////////////////////////////////////////////////////////////
#pragma mark - Private Types, Enumeration and Options


/**
 @struct Fraction.
 
 @field numerator   Numerator of a fraction.
 @field denominator Denominator of a fraction.
 */
typedef struct Fraction {
    int_least64_t numerator;
    int_least64_t denominator;
} Fraction;

/** Values to indicate which of trigonometric functions is used. */
typedef NS_ENUM(NSUInteger, NIBTrigonometricFuntion) {
    /** Trigonometric sine function. */
    NIBTrigonometricSinFunction,
    /** Trigonometric cosine function. */
    NIBTrigonometricCosFunction,
    /** Trigonometric tangent function. */
    NIBTrigonometricTanFunction
};

/** Values to indicate which of hyperbolic functions is used. */
typedef NS_ENUM(NSUInteger, NIBHyperbolicFunction) {
    /** Hyperbolic sine function. */
    NIBHyperbolicSineFunction,
    /** Hyperbolic cosine function. */
    NIBHyperbolicCosineFunction,
    /** Hyperbolic tangent function. */
    NIBHyperbolicTangentFunction
};

/** Values to indicate which of inverse trigonometricfunctions is used. */
typedef NS_ENUM(NSUInteger, NIBInverseTrigonometricFuntion) {
    /** Inverse trigonometric sine function. */
    NIBInverseTrigonometricArcSinFunction,
    /** Inverse trigonometric cosine function. */
    NIBInverseTrigonometricArcCosFunction,
    /** Inverse trigonometric tangent function. */
    NIBInverseTrigonometricArcTanFunction
};

/** Values to indicate which of inversehyperbolic functions is used. */
typedef NS_ENUM(NSUInteger, NIBInverseHyperbolicFunction) {
    /** Inverse hyperbolic sine function. */
    NIBInverseHyperbolicSineFunction,
    /** Inverse hyperbolic sine function. */
    NIBInverseHyperbolicCosineFunction,
    /** Inverse hyperbolic sine function. */
    NIBInverseHyperbolicTangentFunction
};


/////////////////////////////////////////////////////////////////////////////
#pragma mark - Private Constants


/** Max denominator using in the algorithm to convert a double number to fraction. */
static const int_least64_t NIB_MAX_DENOMINATOR = INT_LEAST64_MAX;

/** Approximation error using in the algorithm to convert a double number to fraction.  */
static const double NIB_APPROX_ERROR = 0.0000000000001f;   // 10^-13

/** Calculation error of the calculator. */
static const double NIB_CAL_ERROR = 0.000000000000001f; // 10^-15


/////////////////////////////////////////////////////////////////////////////
#pragma mark - Declaration of Private Functions


static Fraction NIBFractionFromDouble(double);
static BOOL NIBIsNegativeFraction(Fraction);
static int_least64_t NIBGreatCommonDivisor(uint_least64_t, uint_least64_t);
static NSNumber * NIBRoundNumberWithCalculationError(NSNumber *);


/////////////////////////////////////////////////////////////////////////////
#pragma  mark - Class Extension


NS_ASSUME_NONNULL_BEGIN

@interface NIBCalculatorBrain ()

/// -----------------------
/// @name Public Properties
/// -----------------------

@property (readwrite, strong, nonatomic) NSNumber *_Nullable memory;

/// ------------------------
/// @name Private Properties
/// ------------------------

/** The arithmetic cache of the calculator. */
@property (readwrite, strong, nonatomic) NSMutableArray *arithmeticCache;

/** The infix expression. */
@property (readwrite, strong, nonatomic) NSMutableArray *infixExpression;

/** The trigonometric mode for angle. */
@property (readwrite, assign, nonatomic) BOOL isRadianMode;

/// --------------------------
/// @name Operation Processing
/// --------------------------

/**
 Process when operator is equality.
 
 @return Returns the number object after process.
 */
- (NSNumber *_Nullable)processEqualityOperator;

/**
 Process when operation is an parenthesis operator.
 
 @param operator The parenthesis operator.
 
 @return Returns the number object after process.
 */
- (NSNumber *_Nullable)processClosingParenthesisOperator:(NIBOperator *)operator;

/**
 Process when operator is a binary operator.
 
 @param operator The unary operator.
 
 @return Returns the number object after process.
 */
- (NSNumber *_Nullable)processUnaryOperator:(NIBOperator *)operator;

/**
 Process when operator is a binary operator.
 
 @param operator The binary operator.
 
 @return Returns the number object after process.
 */
- (NSNumber *_Nullable)processBinaryOperator:(NIBOperator *)operator;

/// ------------------------
/// @name Calculation Center
/// ------------------------

/**
 Evaluate infix expression.
 
 @param infixExp The infix expression.
 
 @return Returns the number of the expression.
 */
- (NSNumber *_Nullable)evaluateInfixExpression:(NSArray *)infixExp;

/**
 Evaluate posfix expression.
 
 @param postfixExp The postfix expression.
 
 @return Returns the result as a number object of the postfix expression.
 */
- (NSNumber *_Nullable)evaluatePostfixExpression:(NSArray *)postfixExp;

/**
 Perform unary operator on an operand.
 
 @param operator    The unary operator.
 @param operand     The operand to perform unary operation.
 
 @return Returns the result as a number object of the unary operator if it
 is successful. If the operation is not successful, returns
 [NSDecimalNumber notANumber]. Otherwise, returns nil.
 */
- (NSNumber *_Nullable)performUnaryOperator:(NIBOperator *)operator
                                  onOperand:(NSNumber *_Nullable)operand;

/// ---------------------------
/// @name Arithmetic Operations
/// ---------------------------

/**
 Handle division operation of calculation stack.
 
 @param calStack The calculation stack.
 */
- (void)performDivisionOfStack:(NIBCalculatorStack<NSNumber *> *)calStack;

/**
 Handle multiplicaiton operation of calculation stack.
 
 @param calStack The calculation stack.
 */
- (void)performMultiplicationOfStack:(NIBCalculatorStack<NSNumber *> *)calStack;

/**
 Handle substraction operation of calculation stack.
 
 @param calStack The calculation stack.
 */
- (void)performSubstractionOfStack:(NIBCalculatorStack<NSNumber *> *)calStack;

/**
 Handle addition operation of calculation stack.
 
 @param calStack The calculation stack.
 */
- (void)performAdditionOfStack:(NIBCalculatorStack<NSNumber *> *)calStack;

/// ---------------------------
/// @name Functional Operations
/// ---------------------------

/**
 Handle percentage operation of calculation stack.
 
 @param operand The operand to calculate percentage.
 
 @return Returns a number object as a result of the percentage operation
 if it is successful. If the operation is not successful, returns
 [NSDecimalNumber notANumber]. Otherwise, returns nil.
 */
- (NSNumber *)percentageOfOperand:(NSNumber *_Nullable)operand;

/**
 Raise to the power of base. It used to handle root
 and exponent operation.
 
 @param power   The power to raise.
 @param base    The base of exponent operation.
 
 @return Returns a number object as a result of the exponentiation if
 it is successful. If the operation is not successful, returns
 [NSDecimalNumber notANumber]. Otherwise, returns nil.
 */
- (NSNumber *)raiseToPower:(NSNumber *_Nullable)power
                    ofBase:(NSNumber *_Nullable)base;

/**
 Perform trigonometric functions on an operand.
 
 @param trigonometricFunction   The trigonometric functions defined
                                in NIBTrigonometricFuntion.
 @param operand                 The operand to perform trigonometric functions.
 
 @return Returns a number object as a result of the trigonometric function
 if it is successful. If the operation is not successful, returns
 [NSDecimalNumber notANumber]. Otherwise, returns nil.
 */
- (NSNumber *)performTrigonometricFunction:(NIBTrigonometricFuntion)trigonometricFunction
                                 ofOperand:(NSNumber *_Nullable)operand;

/**
 Perform hyperbolic functions on an operand.
 
 @param hyperbolicFunction  The hyperbolic functions defined
                            in NIBHyperbolicFunction.
 @param operand             The operand to perform hyperbolic functions.
 
 @return Returns a number object as a result of the hyperbolic function
 if it is successful. If the operation is not successful, returns
 [NSDecimalNumber notANumber]. Otherwise, returns nil.
 */
- (NSNumber *)performHyperbolicFunction:(NIBHyperbolicFunction)hyperbolicFunction
                              ofOperand:(NSNumber *_Nullable)operand;

/**
 Perform inverse trigonometric functions of an operand.
 
 @param inverseTrigFunc The inverse trigonometric functions
                        defined in NIBInverseTrigonometricFunction.
 @param operand         The operand to perform trigonometric functions.
 
 @return Returns a number object as a result of the inverse trigonometric
 function if it is successful. If the operation is not successful, returns
 [NSDecimalNumber notANumber]. Otherwise, returns nil.
 */
- (NSNumber *)performInverseTrigonometricFunction:(NIBInverseTrigonometricFuntion)inverseTrigFunc
                                        ofOperand:(NSNumber *_Nullable)operand;

/**
 Handle inverse hyperbolic functions.
 
 @param inverseHyperbolicFunc   The inverse trigonometric
                                defined in NIBInverseHyperbolicFunction.
 @param operand                 The operand to perform inverse hyperbolic
                                functions.
 
 @return Returns a number object as a result of the inverse hyperbolic
 function if it is successful. If the operation is not successful, returns
 [NSDecimalNumber notANumber]. Otherwise, returns nil.
 */
- (NSNumber *)performInverseHyperbolicFunction:(NIBInverseHyperbolicFunction)inverseHyperbolicFunc
                                     ofOperand:(NSNumber *_Nullable)operand;

/**
 Perform function of f(x)=1/x.
 
 @param operand The operand to perform a function.
 
 @return Returns a number object as a result of the function if it is
 successful. If the operation is not successful, returns
 [NSDecimalNumber notANumber]. Otherwise, returns nil.
 */
- (NSNumber *)performInverseFunctionOfOperand:(NSNumber *_Nullable)operand;

/**
 Handle logarithm function of a certain base.
 
 @param operand     The operand to find logarithm.
 @param base        The base of a logarithm. Base is a positive real number not
 equal to 1.
 
 @return Returns a number object as a result of the logarithm function if it is
 successful. If the operation is not successful, returns
 [NSDecimalNumber notANumber]. Otherwise, returns nil.
 */
- (NSNumber *)performLogarithmFunctionOf:(NSNumber *_Nullable)operand
                       withRespectToBase:(NSNumber *)base;

/**
 Handle factorial operation of an operand.
 
 @param operand The operand to perform a function.
 
 @return Returns a number object as a result of the factorial function if
 it is successful. If the operation is not successful, returns
 [NSDecimalNumber notANumber]. Otherwise, returns nil.
 */
- (NSNumber *_Nullable)performFactorialOf:(NSNumber *_Nullable)operand;

/**
 Hanlde scientific notation operation of calculation stack.
 
 @param calStack The calculation stack.
 */
- (void)performScientificNotationOfStack:(NIBCalculatorStack<NSNumber *> *)calStack;

/// ----------------------
/// @name Arithmetic Cache
/// ----------------------

/**
 Update the arithmetic cache.
 
 @param exp The expression to cache.
 */
- (void)updateArithmeticCacheWithExpression:(NSArray *_Nullable)exp;

/// -------------
/// @name Helpers
/// -------------

/**
 Check if an operand can be replaced in an infix expression of an instance.
 The operand can be replaced if and only if there is a sole operand and no
 binary operators in the expression.

 @return Returns YES it the operand can be replaced in the infix expression
 of the instance. Otherwise, NO.
 */
- (BOOL)isOperandReplaceableInInfixExpression;

/**
 Count the number of operand in the infix expression of an instance.
 
 @return Returns the number of operand in the infix expression of an instance.
 */
- (NSInteger)countOperandInInfixExpression;

/**
 Check if the infix expression of an instance can be evaluated.
 
 @return Returns YES if the infix expression of the instance can be evaluated.
 Otherwise, NO.
 */
- (BOOL)canEvalualateInfixExpression;

/**
 Check if the infix expression of an instance has mismatched parentheses.
 
 @return Returns YES if the infix expression has mismatched parentheses.
 Otherwise, NO.
 */
- (BOOL)hasMisMatchedParenthesesInInfixExpression;

/**
 Convert to postfix expression from infix expression.
 
 @param infixExp The infix expression.
 
 @return Returns the posfix expression.
 */
- (NSArray *)postfixExpressionFromInfixExpression:(NSArray *)infixExp;

/**
 Check if an angle is equals Pi/2*(2k+1) (k is integer).
 
 @param angle The angle to check.
 
 @return Returns YES if the angle is an odd multiplication of Pi/2, otherwise NO.
 */
- (BOOL)isOddMultiplicationOfPi_2:(double)angle;

/**
 Get the partial infix expression containing the last binary operator and
 operand of the infix expression.
 
 @param infixExp The infix expression.
 
 @return Returns the partical infix expression of the given infix expression.
 If the last part of infix expression having parenthesis, return nil.
 */
- (NSArray *_Nullable)partialInfixExpressionContainingLastElementsFromExpression:(NSArray *)infixExp;

/**
 Get the partial infix expression which is the left operand if add a given
 operator to a whole infix expression. For example: given the expression 3+4x5.
 If the plus sign (+) is added, the partial expression is 3+4x5. If the
 multiplication sign (x) is added, the partial expression is 4x5.
 
 @param infixExp    The infix expression.
 @param operator    The operator to add.
 
 @return Returns the partical infix expression of the given infix expression,
 which is a left operand of adding operator.
 */
- (NSArray *_Nullable)partialInfixExpressionFromExpression:(NSArray *)infixExp
                             asLeftOperandOfAddingOperator:(NIBOperator *)operator;

@end

NS_ASSUME_NONNULL_END


/////////////////////////////////////////////////////////////////////////////
#pragma  mark -

@implementation NIBCalculatorBrain

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        _memory = nil;
        _arithmeticCache = [[NSMutableArray alloc] initWithCapacity:2];
        _isRadianMode = NO;
        _infixExpression = [[NSMutableArray alloc] init];
    }
    
    return self;
}


/////////////////////////////////////////////////////////////////////////////
#pragma mark - Public Methods


#pragma mark Interactive Operations

- (void)pushOperand:(double)operand
{
    [self.infixExpression addObject:[[NSNumber alloc] initWithDouble:operand]];
}

- (NSNumber *)performOperator:(NIBOperator *)operator
{
    return [self performOperator:operator withExperimentalModeOn:NO];
}

- (NSNumber *)performOperator:(NIBOperator *)operator
       withExperimentalModeOn:(BOOL)isExperimentalModeOn
{
    NSArray *cloneInfExp = [self.infixExpression copy];
    NSNumber *result = nil;
    
    /* if an operator is equality */
    if (operator.idx == NIBButtonEquality) {
        result = [self processEqualityOperator];
        
    /* if an operator is unary operator */
    } else if ([operator isUnaryOperator]) {
        result = [self processUnaryOperator:operator];
    
    /* if an operator is closing parenthesis */
    } else if ([operator isClosingParanthesis]) {
        result = [self processClosingParenthesisOperator:operator];
        
    /* otherwise, an operator is binary operator */
    } else if ([operator isBinaryOperator]) {
        result = [self processBinaryOperator:operator];

    /* otherwise, an operator may be open parenthesis */
    } else {
        [self.infixExpression addObject:operator];
    }
    
    // if result is not a number, clear the operand stack and
    // operation stack to avoid future calculation error
    if ([result isEqualToNumber:[NSDecimalNumber notANumber]]) {
        [self.infixExpression removeAllObjects];
    };
    
    /* if the experimental mode on */
    if (isExperimentalModeOn) {
        [self.infixExpression removeAllObjects];
        [self.infixExpression addObjectsFromArray:cloneInfExp];
    }
    
    return result;
}

- (void)addToMemory:(double)value
{
    if (self.memory == nil) {
        self.memory = [[NSNumber alloc] initWithDouble:value];
    } else {
        self.memory = [[NSNumber alloc] initWithDouble:(self.memory.doubleValue + value)];
    }
}

- (void)subtractFromMemory:(double)value
{
    if (self.memory == nil) {
        self.memory = [[NSNumber alloc] initWithDouble:-value];
    } else {
        self.memory = [[NSNumber alloc] initWithDouble:(self.memory.doubleValue - value)];
    }
}

- (void)clearMemory
{
    self.memory = nil;
}

- (void)clearArithmetic
{
    [self.arithmeticCache removeAllObjects];
    [self.infixExpression removeAllObjects];
}

- (void)toggleRadianMode
{
    self.isRadianMode = !self.isRadianMode;
}

- (NSNumber *)constantNumber:(NIBOperator *)operator
{
    NSNumber *result = nil;
    
    switch (operator.idx) {
        case NIBButtonPi:
            result = [[NSNumber alloc] initWithDouble:M_PI];
            break;
            
        case NIBButtonEulerNumber:
            result = [[NSNumber alloc] initWithDouble:M_E];
            break;
            
        case NIBButtonRand:
            result = [[NSNumber alloc] initWithDouble:arc4random_uniform(UINT_FAST32_MAX)/(double)UINT_FAST32_MAX];
            break;
    }
    
    return result;
}

#pragma mark Utilities

- (BOOL)isWaitingForOperandInInfixExpression
{
    NSInteger operandCount = 0;
    NSInteger binaryOperationCount = 0;
   
    /* count the number of operand and binary operator in infix expression */
    for (id token in self.infixExpression) {
        if ([token isKindOfClass:[NSNumber class]]) {
            operandCount++;
            continue;
        }
        if ([token isKindOfClass:[NIBOperator class]] && [token isBinaryOperator]) {
            binaryOperationCount++;
        }
    }

    // the infix expression is waiting for an operand if there is at least
    // one binary operator and at least one operand and the number of
    // of operand is less than than the number of binary operator plus 1
    return (binaryOperationCount > 0 && operandCount > 0 && operandCount < binaryOperationCount + 1);
}

+ (BOOL)isInterger:(NSNumber *)decimalNumber
{
    BOOL isInteger = NO;
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    numberFormatter.locale = [NSLocale currentLocale];
    numberFormatter.numberStyle = NSNumberFormatterDecimalStyle;
    
    /* number string from number */
    NSString *numStr = [numberFormatter stringFromNumber:decimalNumber];
    
    /* count the integer part length */
    NSString *decimalSeparator = [[NSLocale currentLocale] objectForKey:NSLocaleDecimalSeparator];
    NSRange digitsOfIntegerPartRange = [numStr rangeOfString:decimalSeparator];
    
    if (decimalNumber.doubleValue == round(decimalNumber.doubleValue) && digitsOfIntegerPartRange.location == NSNotFound) {
        isInteger = YES;
    }
    
    return isInteger;
}


/////////////////////////////////////////////////////////////////////////////
#pragma mark - Private Methods


#pragma mark Operator Processing

- (NSNumber *)processEqualityOperator
{
    NSNumber *result = nil;
    
    /* if infix expression contains one operand */
    if ([self countOperandInInfixExpression] == 1) {
        
        switch (self.arithmeticCache.count) {
            /* arithmetic cache has one token */
            case 1:
            {
                /* get operand from infix expression */
                NSNumber * __block operand = nil;
                
                for (id obj in self.infixExpression) {
                    if ([obj isKindOfClass:[NSNumber class]]) {
                        operand = obj;
                        break;
                    }
                }
                
                /* token of arithemtic cache */
                id token = [self.arithmeticCache lastObject];
                
                /* if a token is an unary operator */
                if ([token isKindOfClass:[NIBOperator class]] && [token isUnaryOperator]) {
                        /* perform unary operaton */
                        result = [self performUnaryOperator:token onOperand:operand];
                }
                break;
            }
            
            /* arithmetic cache has two tokens */
            case 2:
            {
                /* append the arithmetic cache to the infix expression */
                [self.infixExpression addObjectsFromArray:self.arithmeticCache];
                /* evaluate new infix expression */
                result = [self evaluateInfixExpression:self.infixExpression];
                break;
            }
        }
    
    /* otherwise, infix expression contains more than one operand */
    /* if infix expression can be evaluated and not have mismatched parentheses */
    } else if ( [self canEvalualateInfixExpression] &&
                ![self hasMisMatchedParenthesesInInfixExpression] ) {
        
        /* create arithmetic cache from infix expression */
        NSArray *arithmeticCache = [self partialInfixExpressionContainingLastElementsFromExpression:self.infixExpression];
        
        /* if has arithmetic cache */
        if (arithmeticCache) {
            /* update arithemtic cache */
            [self updateArithmeticCacheWithExpression:arithmeticCache];
        
        /* otherwise, arithmetic cache */
        } else {
            [self updateArithmeticCacheWithExpression:nil];
        }
        
        result = [self evaluateInfixExpression:self.infixExpression];
    
    /* otherwise, infix expression can not be evaluated or having mismatched parentheses */
    /* if infix expression has mismatched parentheses */
    } else if ([self hasMisMatchedParenthesesInInfixExpression]) {
        result = [self evaluateInfixExpression:self.infixExpression];
    }
    
    /*** otherwise, infix expression can not be evaluated, result is nil ***/
    
    /* clear the infix expression */
    [self.infixExpression removeAllObjects];
    
    return result;
}

- (NSNumber *)processClosingParenthesisOperator:(NIBOperator *)operator
{
    NSNumber *result = nil;
    NSArray *partialInfExp = [self partialInfixExpressionFromExpression:self.infixExpression
                                          asLeftOperandOfAddingOperator:operator];
    
    result = [self evaluateInfixExpression:partialInfExp];
    
    /* first token of parital infix expression index */
    NSUInteger firstTokenOfPartialInfExpIdx = [self.infixExpression indexOfObjectIdenticalTo:partialInfExp[0]];
    
    /* if the partial infix expression is different than the infix expression */
    if (firstTokenOfPartialInfExpIdx > 0) {
        self.infixExpression = [NSMutableArray arrayWithArray:[self.infixExpression subarrayWithRange:NSMakeRange(0, firstTokenOfPartialInfExpIdx)]];
        //if (result) [self.infixExpression addObject:result];
    
    /* otherwise, the partial infix expression is the infix expression */
    } else {
        /* clear the infix expression */
        [self.infixExpression removeAllObjects];
    }
    
    return result;
}

- (NSNumber *)processUnaryOperator:(NIBOperator *)operator
{
    NSNumber *result = nil;
    
    /* last token of infix expression */
    id token = [self.infixExpression lastObject];
    
    /* if there is no token in infix expresion, return immediately */
    if (!token) {
        return nil;
        
    }
    
    /* remove last token */
    [self.infixExpression removeLastObject];
    
    /* if a token is a number */
    if ([token isKindOfClass:[NSNumber class]]) {
        /* perform unary operaton */
        result = [self performUnaryOperator:operator onOperand:token];
        
        /* if not have mismatched parentheses */
        if (![self hasMisMatchedParenthesesInInfixExpression]) {
            /* update arithmetic cache */
            NSArray *arithmeticCahe = @[operator];
            [self updateArithmeticCacheWithExpression:arithmeticCahe];
        }
        
    /* otherwise, token is not a number */
    } else {
        /* can not perform unary operation */
        NSLog(@"Can not perform unary operation: %@", operator);
        result = [NSDecimalNumber notANumber];
    }
    
    /* add result from unary operation to the infix expression */
//    [self.infixExpression addObject:result];
    
    return result;
}

- (NSNumber *)processBinaryOperator:(NIBOperator *)operator
{
    NSNumber *result = nil;
    
    /* if the infix expression is waiting for operand */
    if ([self isWaitingForOperandInInfixExpression]) {
        /* replace the last operator with the new one */
        [self.infixExpression removeLastObject];
    }
    
    /* if the infix expression can be evaluated */
    if ([self canEvalualateInfixExpression]) {
        
        /* partical infix expression */
        NSArray *partialInfExp = [self partialInfixExpressionFromExpression:self.infixExpression
                                              asLeftOperandOfAddingOperator:operator];
        
        /* evaluate the partial infix expression */
        result = [self evaluateInfixExpression:partialInfExp];
    }
    
    [self.infixExpression addObject:operator];

    return result;
}

#pragma mark Calculation Center

- (NSNumber *)evaluateInfixExpression:(NSArray *)infixExp
{
    NSNumber *result = nil;
    NSArray *posfixExp = [self postfixExpressionFromInfixExpression:infixExp];
    result = [self evaluatePostfixExpression:posfixExp];
    
    return result;
}

- (NSNumber *)evaluatePostfixExpression:(NSArray *)postfixExp
{
    NIBCalculatorStack<NSNumber *> *calStack = [[NIBCalculatorStack alloc] init];
    
    for (id token in postfixExp) {
        /* if token is number, push to calculation stack */
        if ([token isKindOfClass:[NSNumber class]]) [calStack push:token];
        
        /* if token is an operator */
        if ([token isKindOfClass:[NIBOperator class]]) {
            NIBOperator *operator = (NIBOperator *)token;
            
            switch (operator.idx) {
                /* operator is division */
                case NIBButtonDivision:
                    [self performDivisionOfStack:calStack];
                    break;
                    
                /* operator is multiplication */
                case NIBButtonMultiplication:
                    [self performMultiplicationOfStack:calStack];
                    break;
                    
                /* operator is substraction */
                case NIBButtonSubstraction:
                    [self performSubstractionOfStack:calStack];
                    break;
                    
                /* operator is addition */
                case NIBButtonAddition:
                    [self performAdditionOfStack:calStack];
                    break;
                    
                /* operator is yth root */
                case NIBButtonYthRootOfX:
                {
                    NSNumber *power = [NSNumber numberWithDouble:1.0/[[calStack pop] doubleValue]];
                    NSNumber *result = [self raiseToPower:power ofBase:[calStack pop]];
                    [calStack push:result];
                    break;
                }
                    
                /* operator is x^y */
                case NIBButtonXPowerY:
                {
                    NSNumber *result = [self raiseToPower:[calStack pop] ofBase:[calStack pop]];
                    [calStack push:result];
                    break;
                }
                    
                /* operator is y^x */
                case NIBButtonYPowerX:
                {
                    NSNumber *base = [calStack pop];
                    NSNumber *result  = [self raiseToPower:[calStack pop] ofBase:base];
                    [calStack push:result];
                    break;
                }
                
                /* operator is logy */
                case NIBButtonLogarithmBaseYOfX:
                {
                    NSNumber *base = [calStack pop];
                    NSNumber *result = [self performLogarithmFunctionOf:[calStack pop]
                                                      withRespectToBase:base];
                    [calStack push:result];
                    break;
                }
                    
                /* operator is EE */
                case NIBButtonEE:
                    [self performScientificNotationOfStack:calStack];
                    break;
                
                /* default case, push not a number to calculation stack to make the program fault-tolerance */
                default:
                   [calStack push:[NSDecimalNumber notANumber]];
                    break;
            }
        }
    }
    
    return [calStack pop];
}

- (NSNumber *)performUnaryOperator:(NIBOperator *)operator
                         onOperand:(NSNumber *)operand
{
    NSNumber *result = nil;
    
    switch (operator.idx) {
        /* operator is percentage */
        case NIBButtonPercentage:
            result = [self percentageOfOperand:operand];
            break;
            
        /* operator is square root */
        case NIBButtonSquareRootOfX:
            result = [self raiseToPower:[NSNumber numberWithDouble:(1.0/2)]
                                 ofBase:operand];
            break;
            
        /* operator is cubic root */
        case NIBButtonCubicRootOfX:
            result = [self raiseToPower:[NSNumber numberWithDouble:(1.0/3)]
                                 ofBase:operand];
            break;
            
        /* operator is x^2 */
        case NIBButtonXSquared:
            result = [self raiseToPower:[NSNumber numberWithDouble:2.0]
                                 ofBase:operand];
            break;
            
        /* operator is x^3 */
        case NIBButtonXCubed:
            result = [self raiseToPower:[NSNumber numberWithDouble:3.0]
                                 ofBase:operand];
            break;
            
        /* operator is e^x */
        case NIBButtonEulerNumberPowerX:
            result = [self raiseToPower:operand
                                 ofBase:[[NSNumber alloc] initWithDouble:M_E]];
            break;
            
        /* operator is 10^x */
        case NIBButtonTenPowerX:
            result = [self raiseToPower:operand
                                 ofBase:[[NSNumber alloc] initWithDouble:10.0]];
            break;
            
        /* operator is 2^x */
        case NIBButtonTwoPowerX:
            result = [self raiseToPower:operand
                                 ofBase:[[NSNumber alloc] initWithDouble:2.0]];
            break;
        
        /* operator is sin */
        case NIBButtonSin:
            result = [self performTrigonometricFunction:NIBTrigonometricSinFunction
                                              ofOperand:operand];
            break;
            
        /* operator is cos */
        case NIBButtonCos:
            result = [self performTrigonometricFunction:NIBTrigonometricCosFunction
                                              ofOperand:operand];
            break;
            
        /* operator is tan */
        case NIBButtonTan:
            result = [self performTrigonometricFunction:NIBTrigonometricTanFunction
                                              ofOperand:operand];
            break;
            
        /* operator is sinh */
        case NIBButtonSinh:
            result = [self performHyperbolicFunction:NIBHyperbolicSineFunction
                                           ofOperand:operand];
            break;
            
        /* operator is cosh */
        case NIBButtonCosh:
            result = [self performHyperbolicFunction:NIBHyperbolicCosineFunction
                                           ofOperand:operand];
            break;
            
        /* operator is tanh */
        case NIBButtonTanh:
            result = [self performHyperbolicFunction:NIBHyperbolicTangentFunction
                                           ofOperand:operand];
            break;
            
        /* operator is 1/x */
        case NIBButtonOneOverX:
            result = [self performInverseFunctionOfOperand:operand];
            break;
            
        /* operator is arcsin */
        case NIBButtonArcSin:
            result = [self performInverseTrigonometricFunction:NIBInverseTrigonometricArcSinFunction
                                                     ofOperand:operand];
            break;
            
        /* operator is arccos */
        case NIBButtonArcCos:
            result = [self performInverseTrigonometricFunction:NIBInverseTrigonometricArcCosFunction
                                                     ofOperand:operand];
            break;
            
        /* operator is arctan */
        case NIBButtonArcTan:
            result = [self performInverseTrigonometricFunction:NIBInverseTrigonometricArcTanFunction
                                                     ofOperand:operand];
            break;
            
        /* operator is arcshinh */
        case NIBButtonArcSinh:
            result = [self performInverseHyperbolicFunction:NIBInverseHyperbolicSineFunction
                                                  ofOperand:operand];
            break;
            
        /* operator is arccosh */
        case NIBButtonArcCosh:
            result = [self performInverseHyperbolicFunction:NIBInverseHyperbolicCosineFunction
                                                  ofOperand:operand];
            break;
            
        /* operator is arctanh */
        case NIBButtonArcTanh:
            result = [self performInverseHyperbolicFunction:NIBInverseHyperbolicTangentFunction
                                                  ofOperand:operand];
            break;
            
        /* operator is ln */
        case NIBButtonNaturalLogarithm:
            result = [self performLogarithmFunctionOf:operand
                                    withRespectToBase:[NSNumber numberWithDouble:M_E]];
            break;
            
        /* operator is log10 */
        case NIBButtonCommonLogarithm:
            result = [self performLogarithmFunctionOf:operand
                                    withRespectToBase:[NSNumber numberWithDouble:10]];
            break;
            
        /* operator is log2 */
        case NIBButtonLogarithmBaseTwo:
            result = [self performLogarithmFunctionOf:operand
                                    withRespectToBase:[NSNumber numberWithDouble:2]];
            break;
        
        /* operator is x! */
        case NIBButtonXFactorial:
            result = [self performFactorialOf:operand];
            break;
        
        /* default case, result is not a number to make the program fault-tolerance */
        default:
            result = [NSDecimalNumber notANumber];
            break;
    }
    
    return result;
}

#pragma mark Arithmetic Operations

- (void)performDivisionOfStack:(NIBCalculatorStack<NSNumber *> *)calStack
{
    NSNumber *divisor = nil;
    NSNumber *dividend = nil;
    NSNumber *result = nil;
    
    divisor = [calStack pop];
    dividend = [calStack pop];
    
    /* if either the divisor or dividend is nil or not a number */
    if (!divisor || !dividend ||
        isnan(dividend.doubleValue/divisor.doubleValue) ||
        isinf(dividend.doubleValue/divisor.doubleValue)) {
        
        result = [NSDecimalNumber notANumber];
        
    /* otherwise, the divisor and dividend are valid */
    } else {
        result = [[NSNumber alloc] initWithDouble:(dividend.doubleValue/divisor.doubleValue)];
    }
    
    /* push result to calculation stack */
    [calStack push:result];
}

- (void)performMultiplicationOfStack:(NIBCalculatorStack<NSNumber *> *)calStack
{
    NSNumber *factor2 = nil;
    NSNumber *factor1 = nil;
    NSNumber *result =  nil;
    
    factor2 = [calStack pop];
    factor1 = [calStack pop];
    
    /* if either the factor is nil or not a number */
    if (!factor2 || !factor1 ||
        [factor2 isEqualToNumber:[NSDecimalNumber notANumber]] ||
        [factor1 isEqualToNumber:[NSDecimalNumber notANumber]]) {
        
        result = [NSDecimalNumber notANumber];
    
    /* otherwise, factors are valid */
    } else {
        result = [[NSNumber alloc] initWithDouble:(factor1.doubleValue * factor2.doubleValue)];
    }
    
    /* push result to calculation stack */
    [calStack push:result];
}

- (void)performSubstractionOfStack:(NIBCalculatorStack<NSNumber *> *)calStack
{
    NSNumber *subtrahend = nil;
    NSNumber *minuend = nil;
    NSNumber *result =  nil;
    
    subtrahend = [calStack pop];
    minuend = [calStack pop];
    
    /* if either the subtrahend or minuend is nil or not a number */
    if (!subtrahend || !minuend ||
        [subtrahend isEqualToNumber:[NSDecimalNumber notANumber]] ||
        [minuend isEqualToNumber:[NSDecimalNumber notANumber]]) {
        
        result = [NSDecimalNumber notANumber];
    
    /* otherwise, the subtrahend and minuend are valid */
    } else {
        result = [[NSNumber alloc] initWithDouble:(minuend.doubleValue - subtrahend.doubleValue)];
    }
    
    /* push result to calculation stack */
    [calStack push:result];
}

- (void)performAdditionOfStack:(NIBCalculatorStack<NSNumber *> *)calStack
{
    NSNumber *summand2 = nil;
    NSNumber *summand1 = nil;
    NSNumber *result =  nil;
    
    summand2 = [calStack pop];
    summand1 = [calStack pop];
    
    /* if either of the summands is nil or not a number */
    if (!summand2 || !summand2 ||
        [summand2 isEqualToNumber:[NSDecimalNumber notANumber]] ||
        [summand1 isEqualToNumber:[NSDecimalNumber notANumber]]) {
        
        result = [NSDecimalNumber notANumber];
    
    /* otherwise, both of the summands are valid */
    } else {
        result = [[NSNumber alloc] initWithDouble:(summand1.doubleValue + summand2.doubleValue)];
    }
    
    /* push result to calculation stack */
    [calStack push:result];
}

#pragma mark Functional Operations

- (NSNumber *)percentageOfOperand:(NSNumber *)operand
{
    NSNumber *result = nil;
    
    if (operand == nil || [operand isEqualToNumber:[NSDecimalNumber notANumber]]) {
        result = [NSDecimalNumber notANumber];
    } else {
        result = [[NSNumber alloc] initWithDouble:operand.doubleValue/100];
    }
    
    return result;
}

- (NSNumber *)raiseToPower:(NSNumber *)power ofBase:(NSNumber *)base
{
    
    /* if  a power is nil or not a number or infinity or
       the base is nil or not a number */
    if ( !base || [base isEqualToNumber:[NSDecimalNumber notANumber]] ||
         !power || isnan(power.doubleValue) || isinf(power.doubleValue) ) {
        
        return [NSDecimalNumber notANumber];
    }
    
    /* otherwise, power is a valid double */
    NSNumber *result = nil;
    
    /* convert power to fraction */
    Fraction frac = NIBFractionFromDouble(power.doubleValue);
        
    /* if the power is not rational */
    if (frac.denominator == 0) {
        result = [NSDecimalNumber notANumber];
        
    /* otherwise, the power is rational */
    // the root can not be calculated when the base is negative and
    // the fraction has odd numerator and even denominator
    } else if (base.doubleValue < 0 && (frac.numerator % 2) && !(frac.denominator % 2)) {
        result = [NSDecimalNumber notANumber];
        
    /* otherwise, the root can be calculated */
    /* if the power is interger */
    } else if (frac.denominator == 1) {
        result = [[NSNumber alloc] initWithDouble:pow(base.doubleValue, (double)frac.numerator)];
        
    /* otherwise, the power is not an integer */
    /* if the power is 1/3 -> cubic root */
    } else if (frac.numerator == 1 && frac.denominator == 3) {
        result = [[NSNumber alloc] initWithDouble:cbrt(base.doubleValue)];
        
    /* if the base is negative and the numerator is odd */
    } else if (base.doubleValue < 0 && frac.numerator % 2 != 0) {
        // the pow(base, power) function can not calculate
        // with negative number as base and double value as exponent.
        // Result is -(|base|^(numerator/denominator))
        result = [[NSNumber alloc] initWithDouble:-pow(fabs(base.doubleValue), (double)frac.numerator/frac.denominator)];
        
    /* otherwise, the base is positive or the numerator of the fraction is even */
    } else {
        /* result is base^(numerator/denominator) */
        result = [[NSNumber alloc] initWithDouble:pow(fabs(base.doubleValue), (double)frac.numerator/frac.denominator)];
    }
    
    
    /* if result is infinity, result is not a number  */
    if (isinf(result.doubleValue)) result = [NSDecimalNumber notANumber];
    
    return result;
}

- (NSNumber *)performTrigonometricFunction:(NIBTrigonometricFuntion)trigonometricFunction
                          ofOperand:(NSNumber *)operand
{
    NSNumber *angle = operand;
    
    /* if the anlge is nil or not a number, return not a number */
    if (!angle || [angle isEqualToNumber:[NSDecimalNumber notANumber]]) {
        return [NSDecimalNumber notANumber];
    }
    
    /* otherwise, the angle is not nil */
    NSNumber *result = nil;
    
    switch (trigonometricFunction) {
        /* calculate sin function */
        case NIBTrigonometricSinFunction:
            if (self.isRadianMode) {
                result = [[NSNumber alloc] initWithDouble:sin(angle.doubleValue)];
            } else {
                result = [[NSNumber alloc] initWithDouble:sin(angle.doubleValue*M_PI/180)];
            }
            break;
            
        /* calculate cos function */
        case NIBTrigonometricCosFunction:
            if (self.isRadianMode) {
                result = [[NSNumber alloc] initWithDouble:cos(angle.doubleValue)];
            } else {
                result = [[NSNumber alloc] initWithDouble:cos(angle.doubleValue*M_PI/180)];
            }
            break;
            
        /* calculate tan function */
        case NIBTrigonometricTanFunction:
            /* if the angle is pi, 3*pi, 5*pi, ... */
            if ([self isOddMultiplicationOfPi_2:angle.doubleValue]) {
                result = [NSDecimalNumber notANumber];
            } else if (self.isRadianMode) {
                result = [[NSNumber alloc] initWithDouble:tan(angle.doubleValue)];
            } else {
                result = [[NSNumber alloc] initWithDouble:tan(angle.doubleValue*M_PI/180)];
            }
            break;
            
        /* default case, return not a number to make the program fault-tolerance */
        default:
            result = [NSDecimalNumber notANumber];
            break;
    }
    
    /* if result is a number, round the result with calculation error */
    if (![result isEqual:[NSDecimalNumber notANumber]]) {
        result = NIBRoundNumberWithCalculationError(result);
    }
    
    return result;
}

- (NSNumber *)performHyperbolicFunction:(NIBHyperbolicFunction)hyperbolicFunction
                              ofOperand:(NSNumber *)operand
{
    
    /* if the operand is nil, return not a number */
    if (!operand || [operand isEqualToNumber:[NSDecimalNumber notANumber]]) {
        return [NSDecimalNumber notANumber];
    }
    
    /* otherwise the operand is not nil */
    NSNumber *result = nil;
    
    switch (hyperbolicFunction) {
        /* calculate hyperbolic sine function */
        case NIBHyperbolicSineFunction:
            result = [[NSNumber alloc] initWithDouble:sinh(operand.doubleValue)];
            break;
            
        /* calculate hyperbolic cosine function */
        case NIBHyperbolicCosineFunction:
            result = [[NSNumber alloc] initWithDouble:cosh(operand.doubleValue)];
            break;
            
        /* calculate hyperbolic tangent function */
        case NIBHyperbolicTangentFunction:
            result = [[NSNumber alloc] initWithDouble:tanh(operand.doubleValue)];
            break;
            
        /* default case, return not a number to make the program fault-tolerance */
        default:
            result = [NSDecimalNumber notANumber];
            break;
    }
    
    /* if the result is infinity, result is not a number */
    if (isinf(result.doubleValue)) result = [NSDecimalNumber notANumber];
    
    return result;
}

- (NSNumber *)performInverseTrigonometricFunction:(NIBInverseTrigonometricFuntion)inverseTrigFunc
                                        ofOperand:(NSNumber *)operand
{
    /* if operand is nil or not a number, return not a number */
    if (!operand || [operand isEqualToNumber:[NSDecimalNumber notANumber]]) {
        return [NSDecimalNumber notANumber];
    }
    
    /* otherwise, the operand is not nil */
    NSNumber *result = nil;
    
    switch (inverseTrigFunc) {
        /* calculate arcsin function */
        case NIBInverseTrigonometricArcSinFunction:
            if (operand.doubleValue < -1 || operand.doubleValue > 1) {
                result = [NSDecimalNumber notANumber];
            } else if (self.isRadianMode) {
                result = [[NSNumber alloc] initWithDouble:asin(operand.doubleValue)];
            } else {
                result = [[NSNumber alloc] initWithDouble:asin(operand.doubleValue)*180/M_PI];
            }
            break;
            
        /* calculate arcos function */
        case NIBInverseTrigonometricArcCosFunction:
            if (operand.doubleValue < -1 || operand.doubleValue > 1) {
                result = [NSDecimalNumber notANumber];
            } else if (self.isRadianMode) {
                result = [[NSNumber alloc] initWithDouble:acos(operand.doubleValue)];
            } else {
                result = [[NSNumber alloc] initWithDouble:acos(operand.doubleValue)*180/M_PI];
            }
            break;
            
        /* calculate arctan function */
        case NIBInverseTrigonometricArcTanFunction:
            if (self.isRadianMode) {
                result = [[NSNumber alloc] initWithDouble:atan(operand.doubleValue)];
            } else {
                result = [[NSNumber alloc] initWithDouble:atan(operand.doubleValue)*180/M_PI];
            }
            break;
            
        /* default case, return not a number to make the program fault-tolerance */
        default:
            result = [NSDecimalNumber notANumber];
            break;
    }
    
    return result;
}

- (NSNumber *)performInverseHyperbolicFunction:(NIBInverseHyperbolicFunction)inverseHyperbolicFunc
                                     ofOperand:(NSNumber *)operand
{
    
    /* if operand is nil or not a number, return not a number */
    if (!operand || [operand isEqualToNumber:[NSDecimalNumber notANumber]]) {
        return [NSDecimalNumber notANumber];
    }
    
    /* otherwise, the operand is not nil */
    NSNumber *result =  nil;
    
    switch (inverseHyperbolicFunc) {
        /* calculate arcsinh function */
        case NIBInverseHyperbolicSineFunction:
            result = [[NSNumber alloc] initWithDouble:asinh(operand.doubleValue)];
            break;
            
        /* calculate arccosh function */
        case NIBInverseHyperbolicCosineFunction:
            result = [[NSNumber alloc] initWithDouble:acosh(operand.doubleValue)];
            break;
            
        /* calculate arctanh function */
        case NIBInverseHyperbolicTangentFunction:
            result = [[NSNumber alloc] initWithDouble:atanh(operand.doubleValue)];
            break;
            
        /* default case, return not a number to make the program fault-tolerance */
        default:
            result = [NSDecimalNumber notANumber];
            break;
    }
    
    /* if result is a number, round the result with calculation error */
    if (![result isEqual:[NSDecimalNumber notANumber]]) {
        result = NIBRoundNumberWithCalculationError(result);
    }
    
    return result;
}

- (NSNumber *)performInverseFunctionOfOperand:(NSNumber *)operand
{
    NSNumber *result = nil;
    
    /* if operand is nil or not a number or zero */
    if (!operand || [operand isEqualToNumber:[NSDecimalNumber notANumber]] ||
        operand.doubleValue == 0) {
        
        result = [NSDecimalNumber notANumber];
    
    /* otherwise, the operand is valid to perform reciprocal function of x */
    } else {
        result = [[NSNumber alloc] initWithDouble:1.0/operand.doubleValue];
    }
    
    return result;
}

- (NSNumber *)performLogarithmFunctionOf:(NSNumber *)operand
                       withRespectToBase:(NSNumber *)base
{
    NSNumber *result =  nil;
    
    /* if an operand is nil or zero or not a number or a base is not valid or not a number */
    if (!operand || operand.doubleValue == 0 ||
        [operand isEqualToNumber:[NSDecimalNumber notANumber]] ||
        base.doubleValue <= 0 || base.doubleValue == 1 ||
        [base isEqualToNumber:[NSDecimalNumber notANumber]]) {

        result = [NSDecimalNumber notANumber];
    
    /* otherwise, the operand and a base is valid numbers */
    /* if base is Euler number */
    } else if (base.doubleValue == M_E) {
        result = [[NSNumber alloc] initWithDouble:log(operand.doubleValue)];
    
    /* if the base is 10 */
    } else if (base.doubleValue == 10) {
        result = [[NSNumber alloc] initWithDouble:log10(operand.doubleValue)];
    
    /* if the base is 2 */
    } else if (base.doubleValue == 2) {
        result = [[NSNumber alloc] initWithDouble:log2(operand.doubleValue)];
    
    /* otherwise, the base is another positive number */
    } else {
        result = [[NSNumber alloc] initWithDouble:log(operand.doubleValue)/log(base.doubleValue)];
    }
    
    return result;
}

- (NSNumber *)performFactorialOf:(NSNumber *)operand
{
    NSNumber *result =  nil;
    
    /* if an operand is nil or negative number or not integer number or not a number */
    if (!operand || operand.doubleValue < 0 ||
        operand.doubleValue != round(operand.doubleValue) ||
        [operand isEqualToNumber:[NSDecimalNumber notANumber]]) {
        
        result = [NSDecimalNumber notANumber];
    
    /* otherwise, operand is valid */
    /* if the number is zero */
    } else if (operand == 0) {
        result = [[NSNumber alloc] initWithDouble:1.0];
    
    /* otherwise, the operand is positive integer larger than one */
    } else {
        double temp = 1;
        for (NSUInteger i = 1; i <= (NSUInteger)operand.doubleValue; i++) {
            temp *= i;
            /* if calculation is infinity, result is not a number, stop calculation */
            if (isinf(temp)) {
                result = [NSDecimalNumber notANumber];
                break;
            }
        }
        
        /* if calculation is finity, result is the calculation */
        if (!isinf(temp)) result = [[NSNumber alloc] initWithDouble:temp];
    }
    
    return result;
}

- (void)performScientificNotationOfStack:(NIBCalculatorStack<NSNumber *> *)calStack
{
    NSNumber *power = [calStack pop];
    NSNumber *coefficient = [calStack pop];
    NSNumber *result = nil;
    
    /* if either power or base is nil or not a number */
    if (!power || !coefficient ||
        [power isEqualToNumber:[NSDecimalNumber notANumber]] ||
        [coefficient isEqualToNumber:[NSDecimalNumber notANumber]]) {
        
        result = [NSDecimalNumber notANumber];
    
    /* otherwise, power and base are valid */
    } else {
        result = [[NSNumber alloc] initWithDouble:coefficient.doubleValue * pow(10, power.doubleValue)];
    }
    
    /* if calculation is infinity, result is not a number */
    if (isinf(result.doubleValue)) {
        result = [NSDecimalNumber notANumber];
    }
    
    /* push result to calculation stack */
    [calStack push:result];
}

#pragma mark Arithmetic Cache

- (void)updateArithmeticCacheWithExpression:(NSArray *_Nullable)exp
{
    /* clear cache if needed */
    if (self.arithmeticCache.count > 0) [self.arithmeticCache removeAllObjects];
    
    /* if exp is nil, do nothing */
    if (!exp) {
        return;
    }
    
    /* update arithmetic cache from an infix expression */
    [self.arithmeticCache addObjectsFromArray:exp];
}

#pragma mark Helpers

- (BOOL)isOperandReplaceableInInfixExpression
{
    NSInteger __block countOperand = 0;
    NSInteger __block countBinaryOperator = 0;
    
    for (id obj in self.infixExpression) {
        if ([obj isKindOfClass:[NSNumber class]]) {
            countOperand++;
        } else if ([obj isKindOfClass:[NIBOperator class]] && [obj isBinaryOperator]) {
            countBinaryOperator++;
        }
    }
    
    return (countOperand == 1 && countBinaryOperator == 0);
}

- (NSInteger)countOperandInInfixExpression
{
    NSInteger countOperand = 0;
    
    for (id obj in self.infixExpression) {
        if ([obj isKindOfClass:[NSNumber class]]) countOperand++;
    }
    
    return countOperand;
}

- (BOOL)canEvalualateInfixExpression
{
    NSInteger operandCount = 0;
    NSInteger binaryOperationCount = 0;
    
    /* count the number of operand and binary operator in infix expression */
    for (id token in self.infixExpression) {
        if ([token isKindOfClass:[NSNumber class]]) {
            operandCount++;
        } else if ([token isKindOfClass:[NIBOperator class]] && [token isBinaryOperator]) {
            binaryOperationCount++;
        }
    }
    
    // the infix expression can be evaluated if there is at least one binary
    // operator and the number of operand == the number binary operation + 1
    return (binaryOperationCount > 0 && operandCount == binaryOperationCount + 1);
}

- (BOOL)hasMisMatchedParenthesesInInfixExpression
{
    NSInteger __block countOpenningParentheses = 0;
    NSInteger __block countClosingParentheses = 0;
    
    /* count the number of openning parentheses and of closing parentheses in infix expression */
    for (id obj in self.infixExpression) {
        if ([obj isKindOfClass:[NIBOperator class]] && [obj isOpeningParanthesis]) {
            countOpenningParentheses++;
        } else if ([obj isKindOfClass:[NIBOperator class]] && [obj isOpeningParanthesis]) {
            countClosingParentheses++;
        }
    }
    
    // the infix has mismatched parentheses if the numbers of openning
    // parentheses and closing parentheses are not equal
    return (countOpenningParentheses != countClosingParentheses);
}

- (NSArray *)postfixExpressionFromInfixExpression:(NSArray *)infixExp
{
    NIBCalculatorStack<NIBOperator *> *stack = [[NIBCalculatorStack alloc] init];
    NSMutableArray *posfixExp = [[NSMutableArray alloc] init];
    
    /* read the token in infix expression one by one to the end */
    for (id token in infixExp) {
        /* if a token is a number, add to the posfix */
        if ([token isKindOfClass:[NSNumber class]]) {
            [posfixExp addObject:token];
            
        /* otherwise, token is NIBOperator */
        /* if a token is not a parenthesis */
        } else if (![token isParanthesis]) {
            while ([stack peek] &&
                   [[stack peek] isOpeningParanthesis] == NO &&
                   [[stack peek] comparePriorityWithOperator:token] != NSOrderedAscending) {
                [posfixExp addObject:[stack pop]];
            }
            
            [stack push:token];
            
        /* otherwise, token is either openning parenthesis or closing parenthesis */
        /* if the token is an openning parenthesis */
        } else if ([token isOpeningParanthesis]) {
            /* push the openning parentheis to the stack */
            [stack push:token];
            
        /* otherwise, token is a closing parentheis */
        } else if ([token isClosingParanthesis]) {
            
            /* pop all the operator between two parentheses to the posfix */
            // if the stack runs out without finding an openning parenthesis,
            // then there are mistmatched parenthesis
            while ([stack peek] && [[stack peek] isOpeningParanthesis] == NO) {
                [posfixExp addObject:[stack pop]];
            }
            
            /* pop openning parenthesis */
            [stack pop];
        }
    }
    
    /* if there is still operator token on the stack */
    while ([stack peek]) {
        /* if there is mismatched parenthesis, pop of stack */
        if ([[stack peek] isParanthesis]) {
            [stack pop];
            
        /* otherwise, add the operator to the postfix expression */
        } else {
            [posfixExp addObject:[stack pop]];
        }
    }
    
    return [posfixExp copy];
}

- (BOOL)isOddMultiplicationOfPi_2:(double)angle
{
    BOOL isOddMultiplicationOfPi_2 = NO;
    
    /* if angle is negative, convert to positive angle */
    if (angle < 0) angle = -angle;
    
    NSInteger i = 1;
    double oddPi_2 = (self.isRadianMode) ? M_PI_2 * i : 90.0 * i;
    
    while (angle >= oddPi_2) {
        /* if angle is odd multiplication of M_PI_2 */
        if (angle == oddPi_2 && (i % 2)) {
            isOddMultiplicationOfPi_2 = YES;
            break;
        }
        /* update oddPi */
        i++;
        oddPi_2 = (self.isRadianMode) ? M_PI_2 * i : 90.0 * i;
    }
    
    return isOddMultiplicationOfPi_2;
}

- (NSArray *)partialInfixExpressionContainingLastElementsFromExpression:(NSArray *)infixExp
{
    NSMutableArray *partialInfExp = [[NSMutableArray alloc] init];
    
    /* reverse enumerate an infix expression */
    [infixExp enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id token, NSUInteger __unused idx, BOOL *stop) {
        /* if a token is a number or not a parentheses */
        if ( [token isKindOfClass:[NSNumber class]] ||
             ([token isKindOfClass:[NIBOperator class]] && ![token isClosingParanthesis]) ) {
            
            /* add token to the partial infix expression */
            [partialInfExp insertObject:token atIndex:0];
        }
        
        if (partialInfExp.count == 2) *stop= YES;
    }];
    
    return (partialInfExp.count == 1) ? nil : partialInfExp;
}

- (NSArray *)partialInfixExpressionFromExpression:(NSArray *)infixExp
                    asLeftOperandOfAddingOperator:(NIBOperator *)operator
{
    NSMutableArray *partialInfExp = [[NSMutableArray alloc] init];
    
    switch (operator.idx) {
        /* adding operator is addition or substraction */
        case NIBButtonAddition:
        case NIBButtonSubstraction:
        {
            /* if the infix expression has openning parenthesis only */
            if ([self hasMisMatchedParenthesesInInfixExpression]) {
                
                /* reverse enumerate an infix expression */
                [infixExp enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id token, NSUInteger __unused idx, BOOL *stop) {
                    
                    /* if a token is a number or an operator not openning parenthesis */
                    if( [token isKindOfClass:[NSNumber class]] ||
                       ([token isKindOfClass:[NIBOperator class]] && ![token isOpeningParanthesis]) ) {
                        
                        /* add token to the partial infix expression */
                        [partialInfExp insertObject:token atIndex:0];
                        
                    /* otherwise a token is an openning parenthesis,
                           stop forming infix expression */
                    } else if ([token isKindOfClass:[NIBOperator class]] && [token isOpeningParanthesis]) {
                        *stop = YES;
                    }
                }];
            } else {
                [partialInfExp addObjectsFromArray:self.infixExpression];
            }
            
            break;
        }
            
        /* adding operator is multiplication of division */
        case NIBButtonMultiplication:
        case NIBButtonDivision:
        {
            /* reverse enumerate an infix expression */
            [infixExp enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id token, NSUInteger __unused idx, BOOL *stop) {
                
                // if a token is a number or a token is an operator that
                //  is not an openning parenthesis and have equal or higher
                // precedence than the adding operator
                if( [token isKindOfClass:[NSNumber class]] ||
                    ([token isKindOfClass:[NIBOperator class]] && ![token isOpeningParanthesis] && [token comparePriorityWithOperator:operator] != NSOrderedAscending) ) {
                    
                    /* add token to the partial infix expression */
                    [partialInfExp insertObject:token atIndex:0];
                
                /* otherwise a token has lower precedence than the adding
                   operator or a token is an openning parenthesis, stop forming
                   infix epxression */
                } else {
                    *stop = YES;
                }
            }];
            
            break;
        }
            
        /* adding operator is closing parenthesis */
        case NIBButtonClosingParenthesis:
        {
            /* reverse enumerate an infix expression */
            [infixExp enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id token, NSUInteger __unused idx, BOOL *stop) {
                /* add token to the partial infix expression */
                [partialInfExp insertObject:token atIndex:0];
                
                /* if a token is openning parenthesis, stop */
                if ([token isKindOfClass:[NIBOperator class]] && [token isOpeningParanthesis]) {
                    *stop = YES;
                }
            }];
            
            break;
        }
            
        default:
            [partialInfExp addObject:[self.infixExpression lastObject]];
            break;
    }
    
    return partialInfExp;
}

@end


/////////////////////////////////////////////////////////////////////////////
#pragma mark - Private Functions Implementation


/**
 Convert from double number to Fraction.
 
 @param number The double number.
 
 @return Returns the fraction with numerator and denominator representing the number.
 */
Fraction NIBFractionFromDouble(double number) {
    Fraction frac = {0, 0};
    
    /* if a number is an integer */
    if (number == round(number)) {
        /* fraction is number/1 */
        frac.numerator = (int_least64_t)number;
        frac.denominator = 1;
        
        /* if a number is not an integer */
    } else {
        Fraction fractions[2];
        fractions[0] = (Fraction) {1, 0};
        fractions[1] = (Fraction) {0, 1};
        
        /* approximation always convert to postive */
        double approximation = (number < 0) ? -number : number;
        int_least64_t integerPart = (int_least64_t)approximation;
        
        while (fractions[0].denominator * integerPart + fractions[1].denominator <= NIB_MAX_DENOMINATOR) {
            int_least64_t temp;
            temp = fractions[0].numerator * integerPart + fractions[1].numerator;
            fractions[1].numerator = fractions[0].numerator;
            fractions[0].numerator = temp;
            temp = fractions[0].denominator * integerPart + fractions[1].denominator;
            fractions[1].denominator = fractions[0].denominator;
            fractions[0].denominator = temp;
            
            /* if approximation is perfect */
            if (approximation == integerPart) {
                break;
            
            /* if approximation is acceptable with an error */
            } else if (approximation - integerPart <= NIB_APPROX_ERROR) {
                break;
                
            /* if the number can not be represented as rational form */
            } else if ( NIBIsNegativeFraction(fractions[0]) || NIBIsNegativeFraction(fractions[1]) ) {
                fractions[0] = (Fraction) {1, 0};
                break;
            }
                
            /* update approximation and integer part */
            approximation = 1.0/(approximation - integerPart);
            integerPart = (int_least64_t)approximation;
            
            if (approximation > (double)0x7FFFFFFF) {
                break;
            }
        }
        
        /* get the fraction of a number */
        frac = fractions[0];
        
        /* if valid fraction */
        if (frac.denominator != 0) {
            /* find GCD of numerator and denominator of the fraction */
            int_least64_t greatCommondDivisor = NIBGreatCommonDivisor((uint_least64_t)frac.numerator, (uint_least64_t)frac.denominator);
            
            /* reduce the fraction to simplest form */
            frac.numerator = frac.numerator/greatCommondDivisor;
            frac.denominator = frac.denominator/greatCommondDivisor;
            
            /* return the sign of the fraction if negative */
            if (number < 0) {
                frac.numerator = -frac.numerator;
            }
        }
        
    }
    
    return frac;
}

/**
 Check if a fraction is negative.
 
 @param frac The fraction to check.
 
 @return Returns YES if the fraction is negative, otherwise NO.
 */
static BOOL NIBIsNegativeFraction(Fraction frac) {
    BOOL isNegativeFraction = NO;
    
    if ((frac.numerator < 0 && frac.denominator > 0) ||
        (frac.numerator > 0 && frac.denominator < 0)) {
        isNegativeFraction = YES;
    }
    
    return isNegativeFraction;
}

/**
 Find the great common divisor of two positive integers.
 
 @param number1 The first number.
 @param number2 The second number.
 
 @return Returns the great common divisor of two numbers.
 */
static int_least64_t NIBGreatCommonDivisor(uint_least64_t number1, uint_least64_t number2) {
    uint_least64_t temp;
    
    while (number2 != 0) {
        temp = number1 % number2;
        number1 = number2;
        number2 = temp;
    }
    
    return (int_least64_t)number1;
}

/**
 Round the double with calculation error.
 
 @param doubleNumber The double number to round.
 
 @return Returns the number object after rounding.
 */
static NSNumber * NIBRoundNumberWithCalculationError(NSNumber *doubleNumber) {
    NSNumber *result = nil;
    double roundedVal = round(doubleNumber.doubleValue);
    
    if (fabs(roundedVal - doubleNumber.doubleValue) <= NIB_CAL_ERROR) {
        result = [[NSNumber alloc] initWithDouble:roundedVal];
    } else {
        result = doubleNumber;
    }
    
    return result;
}
