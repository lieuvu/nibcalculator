//
//  NIBButton.m
//  NIBCalculator
//
//  Created by Lieu Vu on 9/8/17.
//  Copyright © 2017 LV. All rights reserved.
//

#import "NIBButton.h"
#import "UIView+Autolayout.h"

/////////////////////////////////////////////////////////////////////////////
#pragma mark - Constants

/** Minimum scale factor for label on buttons. */
static const CGFloat NIBTitleLabelMinScaleFactor = 0.5f;

/** Subscript height multiplier. */
static const CGFloat NIBButtonSubscriptHeightMultiplier = 0.5f;

/** Extra part size multiplier. */
static const CGFloat NIBButtonExtraPartSizeMultiplier = 0.6f;

/** Extra part font size multiplier. */
static const CGFloat NIBButtonExtraPartFontSizeMultiplier = 0.45f;

/** Height multiplier in drawing square root sign. */
static const CGFloat NIBButtonSquareRootSignHeightMultiplier = 0.2f;

/** Size multiplier of the root part in drawing square root sign. */
static const CGFloat NIBButtonRootSizeMultiplier = 0.5f;

/** Font size multiplier of the root part in drawing square root sign. */
static const CGFloat NIBButtonRootFontSizeMultiplier = 0.4f;

/** Height muliplier of the big diagonal line in drawing square root sign. */
static const CGFloat NIBButtonSquareRootSignBigDiagonalLineHeightMultiplier = 0.75f;

/** Height muliplier of the medium diagonal line in drawing square root sign. */
static const CGFloat NIBButtonSquareRootSignMediumDiagonalLineHeightMultiplier = 0.35f;

/** Height muliplier of the tiny diagonal line in drawing square root sign. */
static const CGFloat NIBButtonSquareRootSignTinyDiagonalLineHeightMultiplier = 0.04f;

/** Degree of the big diagonal line in drawing square root sign. */
static const CGFloat NIBButtonSquareRootSignBigDiagonalLineDegree = 10.0f;

/** Degree of the medium diagonal line in drawing square root sign. */
static const CGFloat NIBButtonSquareRootSignMediumDiagonalLineDegree = 20.0f;

/** Degree of the tiny diagonal line in drawing square root sign. */
static const CGFloat NIBButtonSquareRootSignTinyDiagonalLineDegree = 60.0f;

/** Width of line in drawing square root sign. */
static const CGFloat NIBButtonFractionSeperatorWidth = 1.0f;


/////////////////////////////////////////////////////////////////////////////
#pragma mark -

NS_ASSUME_NONNULL_BEGIN

@interface NIBButton ()

/** Normal backgroud of a button. */
@property (readwrite, copy, nonatomic) UIColor *_Nullable normalBackground;

/** Highlighted background of a button. */
@property (readwrite, copy, nonatomic) UIColor *_Nullable highlightedBackground;

/** Normal border width of a button. */
@property (readwrite, assign, nonatomic) CGFloat normalBorderWidth;

/** Normal border color of a button. */
@property (readwrite, copy, nonatomic) UIColor *_Nullable normalBorderColor;

/** Border width of a button when selected. */
@property (readwrite, assign, nonatomic) CGFloat selectedBorderWidth;

/** Border color of a button when selected. */
@property (readwrite, copy, nonatomic) UIColor *_Nullable selectedBorderColor;

@end

NS_ASSUME_NONNULL_END


/////////////////////////////////////////////////////////////////////////////
#pragma mark -

@implementation NIBButton

/////////////////////////////////////////////////////////////////////////////
#pragma mark - Public Methods

/////////////////////////////////////////////////////////////////////////////
#pragma mark - Initializing A Button

- (instancetype)initWithLabelTitle:(NSString *)title
                              font:(UIFont *)font
                               tag:(NIBButtonTag)tag
{
    self =  [[self class] autolayoutView];
    
    if (self) {
        /* initialize property */
        _normalBackground = nil;
        _highlightedBackground = nil;
        _normalBorderWidth = 0.0;
        _normalBorderColor = nil;
        _selectedBorderWidth = 0.0;
        _selectedBorderColor = nil;
        
        /* common properties of NIBButton */
        //self.translatesAutoresizingMaskIntoConstraints = NO;
        self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        self.titleLabel.minimumScaleFactor = NIBTitleLabelMinScaleFactor;
        self.titleLabel.adjustsFontSizeToFitWidth = YES;
        self.titleLabel.font = font;
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setTitle:title forState:UIControlStateNormal];
        self.tag = tag;
    }
    
    return self;
}

- (instancetype)initWithLabelTitle:(NSString *)title
                              font:(UIFont *)font
                         extraPart:(NSString *)extraPart
                              type:(NIBButtonSubcriptSuperscriptType)type
                               tag:(NIBButtonTag)tag
{
    self = [self initWithLabelTitle:title font:font tag:tag];
    
    /* size of title label string */
    NSDictionary *attributes = @{NSFontAttributeName : font};
    CGSize size = [title sizeWithAttributes:attributes];
    
    /* extra part layer */
    CATextLayer *extraPartLayer = [[CATextLayer alloc] init];
    
    /* if the button is superscript */
    if (type == NIBButtonTypeSuperscript) {
        /* make the frame of extra part according to superscript */
        extraPartLayer.frame = CGRectMake(size.width, 0, size.height * NIBButtonExtraPartSizeMultiplier, size.height * NIBButtonExtraPartSizeMultiplier);
        
        /* if the button is subscript */
    } else if (type == NIBButtonTypeSubscript) {
        /* make the frame of extra part according to subscript */
        extraPartLayer.frame = CGRectMake(size.width, size.height * NIBButtonSubscriptHeightMultiplier, size.height * NIBButtonExtraPartSizeMultiplier, size.height * NIBButtonExtraPartSizeMultiplier);
    }
    extraPartLayer.contentsScale = [[UIScreen mainScreen] scale];
    extraPartLayer.foregroundColor = [[UIColor blackColor] CGColor];
    extraPartLayer.alignmentMode = kCAAlignmentLeft;
    extraPartLayer.wrapped = NO;
    extraPartLayer.fontSize = size.height * NIBButtonExtraPartFontSizeMultiplier;
    extraPartLayer.string = extraPart;
    /* extra part width */
    CGFloat extraPartRightWidth = (CGFloat)ceil([extraPartLayer.string sizeWithAttributes:nil].width);
    
    /* adjust the margin of the base label string on special button */
    self.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, extraPartRightWidth);
    
    /* add subscript layer to base babel string */
    [self.titleLabel.layer addSublayer:extraPartLayer];
    
    return self;
}

- (instancetype)initWithLabelTitle:(NSString *)title
                              font:(UIFont *)font
                              root:(NSString *)root
                               tag:(NIBButtonTag)tag
{
    self = [self initWithLabelTitle:title font:font tag:tag];

    /* size of title label string */
    NSDictionary *attributes = @{NSFontAttributeName : font};
    CGSize size = [title sizeWithAttributes:attributes];

    /* draw square root sign */
    UIBezierPath *path = [UIBezierPath bezierPath];
    // move to top right
    CGPoint point = CGPointMake(size.width, size.height * NIBButtonSquareRootSignHeightMultiplier);
    [path moveToPoint:point];
    // draw to top left and down with certain percent of text height
    point.x = 0;
    point.y = size.height * NIBButtonSquareRootSignHeightMultiplier;
    [path addLineToPoint:point];
    // draw big diagonal line donw to bottom of text frame at big diagonal line degree
    point.x = point.x - (CGFloat)tan(NIBButtonSquareRootSignBigDiagonalLineDegree * M_PI / 180.0f) * size.height;
    point.y = point.y + size.height * NIBButtonSquareRootSignBigDiagonalLineHeightMultiplier;
    [path addLineToPoint:point];
    // draw medium sized diagonal back up at medim diagonal line degree
    point.x = point.x - (CGFloat)tan(NIBButtonSquareRootSignMediumDiagonalLineDegree * M_PI / 180.0f) * size.height * NIBButtonSquareRootSignMediumDiagonalLineHeightMultiplier;
    point.y = point.y - size.height * NIBButtonSquareRootSignMediumDiagonalLineHeightMultiplier;
    [path addLineToPoint:point];
    // draw a tiny diagonal back down at degree 3
    point.x = point.x - (CGFloat)tan(NIBButtonSquareRootSignTinyDiagonalLineDegree * M_PI /180.0f) * size.height * NIBButtonSquareRootSignTinyDiagonalLineHeightMultiplier;
    point.y = point.y + size.height * NIBButtonSquareRootSignTinyDiagonalLineHeightMultiplier;
    [path addLineToPoint:point];
    
    /* calculate extra left width */
    CGFloat extraLeftWidth = (CGFloat)ceil(-point.x);
    
    /* form square root sign as a layer */
    CAShapeLayer *squareRootSignLayer = [[CAShapeLayer alloc] init];
    squareRootSignLayer.contentsScale = [[UIScreen mainScreen] scale];
    squareRootSignLayer.path = path.CGPath;
    squareRootSignLayer.lineWidth = 1.25;
    squareRootSignLayer.strokeColor = [[UIColor blackColor] CGColor];
    squareRootSignLayer.fillColor = [[UIColor clearColor] CGColor];
    
    /* create root as a layer */
    CATextLayer *rootLayer = [[CATextLayer alloc] init];
    rootLayer.contentsScale = [[UIScreen mainScreen] scale];
    rootLayer.frame = CGRectMake(-extraLeftWidth, 0, size.height * NIBButtonRootSizeMultiplier, size.height * NIBButtonRootSizeMultiplier);
    rootLayer.wrapped = NO;
    rootLayer.fontSize = size.height * NIBButtonRootFontSizeMultiplier;
    rootLayer.alignmentMode = kCAAlignmentLeft;
    rootLayer.foregroundColor = [[UIColor blackColor] CGColor];
    rootLayer.string = root;
    
    /* add layers to title label */
    [self.titleLabel.layer addSublayer:squareRootSignLayer];
    [self.titleLabel.layer addSublayer:rootLayer];
    
    /* layout title label on square root button */
    self.titleEdgeInsets = UIEdgeInsetsMake(0, extraLeftWidth, 0, 0);
    
    return self;
}

- (instancetype)initWithLabelTitleAsDenominator:(NSString *)denominator
                                           font:(UIFont *)font
                                      numerator:(NSString *)numerator
                                            tag:(NIBButtonTag)tag
{
    self = [self initWithLabelTitle:denominator font:font tag:tag];
    
    /* size of numerator string */
    NSDictionary *attributes = @{NSFontAttributeName : font};
    CGSize size = [numerator sizeWithAttributes:attributes];
    
    /* layout denominator */
    CGFloat extraHeight = size.height;
    self.titleEdgeInsets = UIEdgeInsetsMake(extraHeight, 0, 0, 0);
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    /* numerator */
    UILabel *numeratorLabel = [UILabel autolayoutView];
    numeratorLabel.minimumScaleFactor = NIBTitleLabelMinScaleFactor;
    numeratorLabel.adjustsFontSizeToFitWidth = YES;
    numeratorLabel.font = font;
    numeratorLabel.text = numerator;
    
    /* separator line */
    UIView *seperatorLine = [UILabel autolayoutView];
    seperatorLine.backgroundColor = [UIColor blackColor];
    
    /* layout separator line */
    [[seperatorLine.heightAnchor constraintEqualToConstant:NIBButtonFractionSeperatorWidth] setActive:YES];
    
    /* add separator line to numerator label */
    [numeratorLabel addSubview:seperatorLine];
    
    /* layout seperator line on numerator label */
    [[seperatorLine.leadingAnchor constraintEqualToAnchor:numeratorLabel.leadingAnchor] setActive:YES];
    [[seperatorLine.bottomAnchor constraintEqualToAnchor:numeratorLabel.bottomAnchor] setActive:YES];
    [[seperatorLine.widthAnchor constraintEqualToAnchor:numeratorLabel.widthAnchor] setActive:YES];
    
    /* add numerator label to fraction button */
    [self addSubview:numeratorLabel];
    
    /* layout numerator label on fraction button */
    [[numeratorLabel.topAnchor constraintEqualToAnchor:self.topAnchor] setActive:YES];
    [[numeratorLabel.centerXAnchor constraintEqualToAnchor:self.centerXAnchor] setActive:YES];
    [[numeratorLabel.widthAnchor constraintEqualToAnchor:self.titleLabel.widthAnchor] setActive:YES];
    [[numeratorLabel.heightAnchor constraintEqualToAnchor:self.titleLabel.heightAnchor] setActive:YES];
    [[numeratorLabel.heightAnchor constraintEqualToAnchor:self.heightAnchor multiplier:0.5] setActive:YES];
    
    return self;
}


/////////////////////////////////////////////////////////////////////////////
#pragma mark - Custom Button Effect

- (void)setBackground:(UIColor *)background highlightedBackground:(UIColor *)highlightedBackground
{
    self.normalBackground = background;
    self.highlightedBackground = highlightedBackground;
    
    /* set background color */
    self.backgroundColor = self.normalBackground;
}

- (void)setBorderWidth:(CGFloat)width borderColor:(UIColor *)color
{
    self.normalBorderWidth = width/[[UIScreen mainScreen] scale];
    self.normalBorderColor = color;
    
    /* draw border and border color */
    self.layer.borderWidth = self.normalBorderWidth;
    self.layer.borderColor = self.normalBorderColor.CGColor;
}

- (void)setSelectedEffectBorderWidth:(CGFloat)width borderColor:(UIColor *)color
{
    self.selectedBorderWidth = width/[[UIScreen mainScreen] scale];
    self.selectedBorderColor = color;
}

- (void)toggleEffect
{
    self.selected = !self.selected;
    
    if (self.selected) {
        self.layer.borderWidth = self.selectedBorderWidth;
        self.layer.borderColor = self.selectedBorderColor.CGColor;
    } else {
        self.layer.borderWidth = self.normalBorderWidth;
        self.layer.borderColor = self.normalBorderColor.CGColor;
    }
}


/////////////////////////////////////////////////////////////////////////////
#pragma mark - Overriding

- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    
    if (highlighted) {
        self.backgroundColor = self.highlightedBackground;
    } else {
        self.backgroundColor = self.normalBackground;
    }
}

@end
