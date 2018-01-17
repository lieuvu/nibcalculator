//
//  NIBCalculatorViewController+UpdateDisplay.m
//  NIBCalculator
//
//  Created by Lieu Vu on 11/15/17.
//  Copyright © 2017 LV. All rights reserved.
//

#import "NIBCalculatorViewController+UpdateDisplay.h"
#import "NIBCalculatorViewController+Helpers.h"
#import "NIBCalculatorBrain.h"
#import "NIBCalculatorPortraitView.h"
#import "NIBCalculatorLandscapeView.h"

/////////////////////////////////////////////////////////////////////////////
#pragma mark - Private Category


NS_ASSUME_NONNULL_BEGIN

@interface NIBCalculatorViewController (UpdateDisplay_Private)

/**
 Check if a string contains only zeros after a decimal separator.
 
 @param numStr The string to check.
 
 @return Returns YES if the string contains only zeros after the decimal
 separator. Otherwise, NO.
 */
- (BOOL)containOnlyZerosAfterDecimalSeparatorInString:(NSString *)numStr;

/**
 Create a string from a number object limited to a maximum displayable digits.
 
 @param number      The number object.
 @param maxDigits   The maximum digits of a number to display.
 
 @return Returns the string that contains maximum allowed digits to display.
 */
- (NSString *)stringOfDecimalNumber:(NSNumber *)number
               maxDisplayableDigits:(NSUInteger)maxDigits;

/**
 Count a number of digits of integer part of a number object that is a decimal
 number with a maximum displayable digits.
 
 @param number      The number object that is a decimal number.
 @param maxDigits   The maximum digits of a number to display.
 
 @return Returns the number of digits of integer part of a number object.
 */
- (NSUInteger)digitsOfIntegerPartOfDecimalNumber:(NSNumber *)number
                            maxDisplayableDigits:(NSUInteger)maxDigits;

/**
 Create a number string by removing insignificant digits from a given
 number string. For example, the number string "1000.054000" will become
 "1000.054".
 
 @param numStr The input number string.
 
 @return Returns the new number string after removing insignificant digits.
 */
- (NSString *)stringByRemovingInsignificantDigitsFromString:(NSString *)numStr;

/**
 Create a number string by adding a grouping separator to a given number string.
 The grouping separator can be a space or a comma depending on the current
 locale.
 
 @param numStr The input number string.
 
 @return Returns the new number string after adding the grouping seprator.
 */
- (NSString *)stringByAddingGroupingSeparatorToString:(NSString *)numStr;

/**
 Create a string in scientific notation of a number object limited to a maximum
 displayable digits.
 
 @param number      The number.
 @param maxDigits   The maximum digits allowed to display.
 
 @return Returns the string in scientifc notation of a number object.
 */
- (NSString *_Nullable)stringInScientificNotationOfNumber:(NSNumber *)number
                                     maxDisplayableDigits:(NSUInteger)maxDigits;

/**
 Check if a number object needs to display in scientific notation limited to a
 maximum digits to display.
 
 @param number      The number.
 @param maxDigits   The maximum digits of a number to display.
 
 @return Returns YES if the number object needs to be displayed in scientific
 notation. Otherwise, NO.
 */
- (BOOL)needScienficNotationOfDecimalNumber:(NSNumber *)number
                       maxDisplayableDigits:(NSUInteger)maxDigits;

@end

NS_ASSUME_NONNULL_END


/////////////////////////////////////////////////////////////////////////////
#pragma mark - Private Category Implementation


@implementation NIBCalculatorViewController (UpdateDisplay_Private)

- (BOOL)containOnlyZerosAfterDecimalSeparatorInString:(NSString *)numStr
{
    NSString *temp = [self stringFromString:numStr withRevmovalOptions:NIBSymbolRemovalGroupingSeparator];
    NSString *decimalSeperator = [[NSLocale currentLocale] decimalSeparator];
    NSUInteger zeroCount = 0;
    
    /* get the string after decimal seperator */
    temp = [temp substringFromIndex:[temp rangeOfString:decimalSeperator].location+1];
    
    for (NSUInteger i = 0; i < temp.length; i++) {
        if ([temp characterAtIndex:i] == '0') {
            zeroCount++;
        }
    }
    
    return (zeroCount == temp.length);
}

- (NSString *)stringOfDecimalNumber:(NSNumber *)number
               maxDisplayableDigits:(NSUInteger)maxDigits
{
    /* check if the number is an integer and return immediately */
    if ([NIBCalculatorBrain isInterger:number]) {
        return @"Integer!";
    }
    
    /* otherwise, it is a decimal. However the number can be still
     an integer with small decimal up to 15 digits */
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    numberFormatter.locale = [NSLocale currentLocale];
    numberFormatter.numberStyle = NSNumberFormatterDecimalStyle;
    numberFormatter.maximumFractionDigits = maxDigits-1;
    
    /* number string from number */
    NSString *numStr = [numberFormatter stringFromNumber:number];
    
    /* count digits of integer part */
    NSUInteger  digitsOfIntegerPart = [self digitsOfIntegerPartOfDecimalNumber:number maxDisplayableDigits:maxDigits];
    
    /* if the digits of integer part equal the number of digits in the string, return immediately */
    if (digitsOfIntegerPart == [self digitsOfString:numStr]) {
        return @"Integer";
    }
    
    /*--- otherwise, the number is decimal ---*/
    
    NSString *result = nil;
    
    /* A block to find the optimized number of round digits after decimal separator of a decimal number */
    NSUInteger (^findOptimizedRoundDigits) (NSNumber *, NSUInteger) = ^ NSUInteger (NSNumber *decimalNum, NSUInteger maxRoundDigits) {
        
        NSInteger i;
        for (i = (NSInteger)maxRoundDigits; i >= 0; i--) {
            double roundNum = round((decimalNum.doubleValue) * pow(10, i))/pow(10, i);
            if (decimalNum.doubleValue != roundNum) break;
        }
        
        return (i == (NSInteger)maxRoundDigits) ? maxRoundDigits : (NSUInteger)(i + 1);
    };
    
    /* find the max number of round digits after decimal separator */
    NSUInteger maxRoundDigits = maxDigits - digitsOfIntegerPart;
    
    /* find the optimized number of round digits after decimal separator */
    NSUInteger optimizedRoundDigits = findOptimizedRoundDigits(number, maxRoundDigits);
    
    /* round the absolute value of the number */
    double roundNumber = round(fabs(number.doubleValue) * pow(10, optimizedRoundDigits));
    
    /* convert round number to string */
    NSMutableString *roundNumberStr = [[NSMutableString alloc] initWithFormat:@"%lld", (long long)roundNumber];
    
    /* if round number string has less digits than the max digits */
    if (roundNumberStr.length <= optimizedRoundDigits) {
        NSUInteger roundNumberStrLenght = roundNumberStr.length;
        /* padding zero to the beginning */
        for (NSUInteger i = 0; i <= optimizedRoundDigits-roundNumberStrLenght; i++) {
            [roundNumberStr insertString:@"0" atIndex:0];
        }
    }
    
    /* put back the decimal separator */
    [roundNumberStr insertString:[[NSLocale currentLocale] decimalSeparator] atIndex:roundNumberStr.length-optimizedRoundDigits];
    
    /* put back the negative sign if needed */
    if (number.doubleValue < 0) {
        [roundNumberStr insertString:NIBNegativePrefix atIndex:0];
    }
    
    result = [self stringByRemovingInsignificantDigitsFromString:roundNumberStr];
    result = [self stringByAddingGroupingSeparatorToString:result];
    
    return result;
}

- (NSUInteger)digitsOfIntegerPartOfDecimalNumber:(NSNumber *)number
                            maxDisplayableDigits:(NSUInteger)maxDigits
{
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    numberFormatter.locale = [NSLocale currentLocale];
    numberFormatter.numberStyle = NSNumberFormatterDecimalStyle;
    numberFormatter.maximumFractionDigits = maxDigits-1;
    
    /* number string from number */
    NSString *numStr = [numberFormatter stringFromNumber:number];
    
    /* count the integer part length */
    NSString *decimalSeparator = [[NSLocale currentLocale] objectForKey:NSLocaleDecimalSeparator];
    NSRange digitsOfIntegerPartRange = [[self stringFromString:numStr withRevmovalOptions:(NIBSymbolRemovalGroupingSeparator | NIBSymbolRemovalNegativePrefix)] rangeOfString:decimalSeparator];
    NSUInteger digitsOfIntegerPart;
    
    /* if there is no decimal separtor found */
    if (digitsOfIntegerPartRange.location == NSNotFound) {
        digitsOfIntegerPart = [self digitsOfString:numStr];
    } else {
        digitsOfIntegerPart = digitsOfIntegerPartRange.location;
    }
    
    return digitsOfIntegerPart;
}

- (NSString *)stringByRemovingInsignificantDigitsFromString:(NSString *)numStr
{
    NSString *decimalSeparator = [[NSLocale currentLocale] objectForKey:NSLocaleDecimalSeparator];
    NSString *result = nil;
    
    NSUInteger __block insignificantDigitsAfterDecimalSeparator = 0;
    
    /* count insignificant digits after decimal separator */
    [numStr enumerateSubstringsInRange:NSMakeRange(0, numStr.length) options:(NSStringEnumerationReverse | NSStringEnumerationByComposedCharacterSequences) usingBlock:^(NSString *substring, NSRange __unused substringRange, NSRange __unused enclosingRange, BOOL * stop) {
        /* stop when reach decimal or a digit not zero */
        if ([substring isEqualToString:decimalSeparator] ||
            ![substring isEqualToString:@"0"]) {
            *stop = YES;
        } else {
            insignificantDigitsAfterDecimalSeparator++;
        }
    }];
    
    /* create result string by removing insignificant digits after decimal separator */
    result = [numStr substringToIndex:numStr.length-insignificantDigitsAfterDecimalSeparator];
    
    return result;
}

- (NSString *)stringByAddingGroupingSeparatorToString:(NSString *)numStr
{
    NSString *groupingSeparator = [[NSLocale currentLocale] objectForKey:NSLocaleGroupingSeparator];
    NSString *decimalSeparator = [[NSLocale currentLocale] objectForKey:NSLocaleDecimalSeparator];
    NSMutableString *result = [[NSMutableString alloc] initWithString:[self stringFromString:numStr withRevmovalOptions:NIBSymbolRemovalGroupingSeparator]];
    NSUInteger digitsOfIntegerPart, decimalSeparatorIdx;
    
    decimalSeparatorIdx = [result rangeOfString:decimalSeparator].location;
    
    /* if not found decimal separator in a number string, it is integer number */
    if (decimalSeparatorIdx == NSNotFound) {
        digitsOfIntegerPart = [result length];
        
        /* otherwise, the number is decimal number */
    } else {
        digitsOfIntegerPart = decimalSeparatorIdx;
    }
    
    if (digitsOfIntegerPart > 3) {
        for (NSUInteger i = digitsOfIntegerPart-1, j = 1; i >= 1; i--, j++) {
            if (j % 3 == 0) {
                [result insertString:groupingSeparator atIndex:i];
            }
        }
    }
    
    return [NSString stringWithString:result];
}

- (NSString *)stringInScientificNotationOfNumber:(NSNumber *)number
                            maxDisplayableDigits:(NSUInteger)maxDigits
{
    /* A block to generate scientific notation format of positive
     decimal number with max decimal digits */
    NSString * (^getScientificNotationFormatOfPositiveDecimalNumber)(NSUInteger) = ^ NSString * (NSUInteger maxDecDigits) {
        NSString *digitSymbol = @"0";
        NSString *decimalSeparator = @".";
        NSString *hashSymbol = @"#";
        NSString *exponentSymbol = @"E";
        
        /* form the  positive format "0.#{maxDecDigits}E0" */
        NSMutableString *numberFormat = [[NSMutableString alloc] initWithString:digitSymbol];
        [numberFormat appendString:decimalSeparator];
        for (NSUInteger i = 0; i < maxDecDigits; i++) {
            [numberFormat appendString:hashSymbol];
        }
        [numberFormat appendString:exponentSymbol];
        [numberFormat appendString:digitSymbol];
        
        return numberFormat;
    };
    
    /* max decimal digits in mantissa assumming 1 digit for integer part
     1 digit for exponent symbol, 1 digit for exponent power */
    NSUInteger maxDecDigits = maxDigits - 3;
    
    /* form the positive format "0.#{maxDecDigits}E0"
     and negative format "-0.#{maxDecDigits}E0" */
    NSString *positiveFormat =  getScientificNotationFormatOfPositiveDecimalNumber(maxDecDigits);
    NSString *negativeFormat = [[NSString alloc] initWithFormat:@"-%@", positiveFormat];
    
    /* number formatter according to the positve format and negative format */
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    numberFormatter.locale = [NSLocale currentLocale];
    numberFormatter.exponentSymbol = NIBExponentSymbol;
    numberFormatter.positiveFormat = positiveFormat;
    numberFormatter.negativeFormat = negativeFormat;
    
    /* number string from the format */
    NSString *numStr = [numberFormatter stringFromNumber:number];
    
    /* count the number of digits in number string including exponent symbol */
    NSUInteger digitsOfNumStr = [self digitsOfString:numStr];
    
    NSString *result = nil;
    
    /* if the number of digits of number string is less than or equal the max digits */
    if (digitsOfNumStr <= maxDigits) {
        /* the number string is returned */
        result = numStr;
        
        /* if the number of digits of number string is larger than the max digits */
    } else if (digitsOfNumStr > maxDigits) {
        /* exponent part length */
        NSUInteger exponentPartLength = numStr.length - [numStr rangeOfString:NIBExponentSymbol].location;
        
        // update max decimal digits in the mantissa, max digits
        // minus 1 digit for integer part, the lenght of exponent part
        maxDecDigits = maxDigits - 1 - exponentPartLength;
        
        /* update positive format and negative format */
        positiveFormat = getScientificNotationFormatOfPositiveDecimalNumber(maxDecDigits);
        negativeFormat = [[NSString alloc] initWithFormat:@"-%@", positiveFormat];
        
        /* update number format */
        numberFormatter.positiveFormat = positiveFormat;
        numberFormatter.negativeFormat = negativeFormat;
        
        /* the new number string is resturned */
        result = [numberFormatter stringFromNumber:number];
    }
    
    return result;
}

- (BOOL)needScienficNotationOfDecimalNumber:(NSNumber *)number
                       maxDisplayableDigits:(NSUInteger)maxDigits
{
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    numberFormatter.locale = [NSLocale currentLocale];
    numberFormatter.positiveFormat = @"0.#E0";
    numberFormatter.negativeFormat = @"-0.#E0";
    
    /* find the exponent of the scientific notation display */
    NSString *numberStr = [numberFormatter stringFromNumber:number];
    NSInteger exponent = [[numberStr substringFromIndex:[numberStr rangeOfString:@"E"].location+1] integerValue];
    
    /* if the exponent is larger than or equals maxDigits, return YES */
    return (NSUInteger)labs(exponent) >= maxDigits;
}

@end


/////////////////////////////////////////////////////////////////////////////
#pragma mark - Category Implementation


@implementation NIBCalculatorViewController (UpdateDisplay)

- (void)updateMainDisplaysWithNumber:(NSNumber *)number
                maxDisplayableDigits:(NSUInteger)maxDigits
{
    if (!number) {
        return;
    }
    
    if ([number isEqualToNumber:[NSDecimalNumber notANumber]]) {
        self.portraitCalculatorView.mainDisplay.text = NIBMainDisplayErrorText;
        self.landscapeCalculatorView.mainDisplay.text = NIBMainDisplayErrorText;
        return;
    }
    
    [self updateMainDisplayOfPortraitCalculatorViewWithNumber:number maxDisplayableDigits:maxDigits];
    [self updateMainDisplayOfLandscapeCalculatorViewWithNumber:number maxDisplayableDigits:maxDigits];
}

- (void)updateMainDisplaysWithString:(NSString *)numStr
{
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    numberFormatter.locale = [NSLocale currentLocale];
    numberFormatter.numberStyle = NSNumberFormatterDecimalStyle;
    numberFormatter.lenient = YES;
    
    /* if a decimal number string contains only zero after decimals */
    if ( [numStr containsString:[[NSLocale currentLocale] decimalSeparator]] &&
        [self containOnlyZerosAfterDecimalSeparatorInString:numStr] ) {
        
        /* convert to number */
        NSNumber *number = [numberFormatter numberFromString:numStr];
        
        numberFormatter.positiveFormat = @"0.#E0";
        numberFormatter.negativeFormat = @"-0.#E0";
        
        /* find the exponent of scientific notation */
        NSString *temp = [numberFormatter stringFromNumber:number];
        NSInteger exponent = [[temp substringFromIndex:[temp rangeOfString:@"E"].location+1] integerValue];
        
        /* if the portrait display is not in scientific notation and the
         number in scientific notation form has exponent larger than
         the max digits in portrait */
        if ( ![self.portraitCalculatorView.mainDisplay.text containsString:NIBExponentSymbol] &&
            (NSUInteger)labs(exponent) >= NIBMaxDigitsInPortrait ) {
            
            self.portraitCalculatorView.mainDisplay.text = [self stringInScientificNotationOfNumber:number maxDisplayableDigits:NIBMaxDigitsInPortrait];
            
            /* otherwise, portrait display is either in scientific notation or
             the number in scientific notation form has exponent smaller than
             the max digits in portrait */
            /* if the portrait display is not in scientific notation => the number
             in scientific notation for has exponent smaller than the max digits
             in portrait */
        } else if (![self.portraitCalculatorView.mainDisplay.text containsString:NIBExponentSymbol]) {
            self.portraitCalculatorView.mainDisplay.text = numStr;
        }
        
        self.landscapeCalculatorView.mainDisplay.text = numStr;
        
        return;
    }
    
    /*--- otherwise, the decimal number string contains significant digit(s)
     after decimal seperator  ---*/
    
    /* the number formatted according to the current locale */
    NSString *formatedNumberStr = [self stringFromString:numStr withRevmovalOptions:NIBSymbolRemovalGroupingSeparator];
    
    /* max digits to display */
    NSUInteger maxDigits = [self digitsOfString:numStr];
    
    [self updateMainDisplayOfPortraitCalculatorViewWithNumber:[numberFormatter numberFromString:formatedNumberStr] maxDisplayableDigits:maxDigits];
    [self updateMainDisplayOfLandscapeCalculatorViewWithNumber:[numberFormatter numberFromString:formatedNumberStr] maxDisplayableDigits:maxDigits];
}

- (void)updateMainDisplayOfPortraitCalculatorViewWithNumber:(NSNumber *)number
                                       maxDisplayableDigits:(NSUInteger)maxDigits
{
    
    /* keep the displayable digits not larger than the limit */
    if (maxDigits > NIBMaxDigitsInPortrait) maxDigits = NIBMaxDigitsInPortrait;
    
    /* prevent a number displayed as -0 */
    if (number.doubleValue == 0) number = [[NSNumber alloc] initWithDouble:0];
    
    /* if number is integer */
    if ([NIBCalculatorBrain isInterger:number]) {
        
        /* if the number is within range */
        if (number.doubleValue <= NIBMaxFullDisplayablePositiveIntegerInPortrait &&
            number.doubleValue >= NIBMinFullDisplayableNegativeIntegerInPortrait) {
            
            NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
            numberFormatter.locale = [NSLocale currentLocale];
            numberFormatter.numberStyle = NSNumberFormatterDecimalStyle;
            numberFormatter.usesGroupingSeparator = YES;
            numberFormatter.usesSignificantDigits = YES;
            numberFormatter.maximumSignificantDigits = maxDigits;
            
            self.portraitCalculatorView.mainDisplay.text = [numberFormatter stringFromNumber:number];
            
        /* otherwise, the number is out of range. This number is only created in landscape view */
        } else {
            self.portraitCalculatorView.mainDisplay.text = [self stringInScientificNotationOfNumber:number maxDisplayableDigits:maxDigits];
        }
        
    /*--- otherwise, the number is decimal ---*/
        
    /* if the number needs to display in scientific notation */
    } else if ([self needScienficNotationOfDecimalNumber:number maxDisplayableDigits:NIBMaxDigitsInPortrait]) {
            self.portraitCalculatorView.mainDisplay.text = [self stringInScientificNotationOfNumber:number maxDisplayableDigits:maxDigits];
      
    /* otherwise, the number display normally */
    } else {
        self.portraitCalculatorView.mainDisplay.text = [self stringOfDecimalNumber:number maxDisplayableDigits:maxDigits];
    }
}

- (void)updateMainDisplayOfLandscapeCalculatorViewWithNumber:(NSNumber *)number
                                        maxDisplayableDigits:(NSUInteger)maxDigits
{
    if (maxDigits > NIBMaxDigitsInLandscape) {
        maxDigits = NIBMaxDigitsInLandscape;
    }
    
    /* prevent a number displayed as -0 */
    if (number.doubleValue == 0) number = [[NSNumber alloc] initWithDouble:0];
    
    /* if number is integer */
    if ([NIBCalculatorBrain isInterger:number]) {
        
        /* if the number is within range */
        if (number.doubleValue < NIBMaxFullDisplayablePositiveIntegerInLandscape &&
            number.doubleValue >= NIBMinFullDisplayableNegativeIntegerInLandscape) {
            NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
            numberFormatter.locale = [NSLocale currentLocale];
            numberFormatter.numberStyle = NSNumberFormatterDecimalStyle;
            numberFormatter.usesGroupingSeparator = YES;
            numberFormatter.usesSignificantDigits = YES;
            numberFormatter.maximumSignificantDigits = maxDigits;
            self.landscapeCalculatorView.mainDisplay.text = [numberFormatter stringFromNumber:number];
            
        /* otherwise, the number is out of range */
        } else {
            self.landscapeCalculatorView.mainDisplay.text = [self stringInScientificNotationOfNumber:number maxDisplayableDigits:maxDigits];
        }
    
    /*--- otherwise, the number is decimal ---*/
     
    /* if the number needs to display in scientific notation */
    } else if ([self needScienficNotationOfDecimalNumber:number maxDisplayableDigits:NIBMaxDigitsInLandscape]) {
        self.landscapeCalculatorView.mainDisplay.text = [self stringInScientificNotationOfNumber:number maxDisplayableDigits:NIBMaxDigitsInLandscape];
        
    /* otherwise, the number display normally */
    } else {
        self.landscapeCalculatorView.mainDisplay.text = [self stringOfDecimalNumber:number maxDisplayableDigits:maxDigits];
    }
}

@end

