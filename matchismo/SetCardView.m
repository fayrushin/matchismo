//
//  SetGameView.m
//  matchismo
//
//  Created by Равил Файрушин on 19.08.15.
//  Copyright (c) 2015 Равил Файрушин. All rights reserved.
//

#import "SetCardView.h"

@interface SetCardView()



@end

@implementation SetCardView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

-(void)setPan:(UIPanGestureRecognizer *)pan
{
    if (!_pan) {
        _pan = [[UIPanGestureRecognizer alloc] init];
    }
    _pan = pan;
    [self setNeedsDisplay];
}

-(void)setCardFeatures:(SetCard *)card
{
    self.color = card.color;
    self.symbol = card.symbol;
    self.shading = card.shading;
    self.number = card.number;
}
-(void)setShading:(NSUInteger)shading
{
    _shading = shading;
    [self setNeedsDisplay];
}

-(void)setSymbol:(NSUInteger)symbol
{
    _symbol = symbol;
    [self setNeedsDisplay];

}

-(void)setNumber:(NSUInteger)number
{
    _number = number;
    [self setNeedsDisplay];
    
}
-(void)setColor:(NSUInteger)color
{
    _color = color;
    [self setNeedsDisplay];
}
-(void)setChoosen:(BOOL)choosen
{
    _choosen = choosen;
    if (self.choosen) {
        self.backgroundColor = [UIColor grayColor];
    }
    else self.backgroundColor = [UIColor whiteColor];
    [self setNeedsDisplay];
}

-(void)setShowStar:(BOOL)showStar
{
    _showStar = showStar;
    [self setNeedsDisplay];
}


-(void) drawRect:(CGRect)rect
{
    [self drawSymbol];
    
}

-(void)drawSymbol
{
    CGRect bounds = self.bounds;
    CGPoint center;
    center.x = bounds.origin.x + bounds.size.width/2.0;
    
    CGFloat width = [self sizeForSymbol].x;
    CGFloat height =[self sizeForSymbol].y;
    
    UIBezierPath *path; //= [[UIBezierPath alloc] init];
    
    CGFloat x = center.x - width/2.0;
    if (self.symbol == 1)
        path = [self drawWavePath:height width:width centerX:x];
    if (self.symbol == 2)
        path = [self drawDiamondPath:height width:width centerX:x];
    if (self.symbol == 3)
        path =[self drawOvalPath:height width:width centerX:x];

    
    [[self colorAsInt:self.color] setStroke];
    [path stroke];
    if (self.shading == 1) {
        [[self colorAsInt:self.color] setFill];
        [path fill];
        
    }
    else if (self.shading == 2){
        [self setStripes:path];
    }
    
    if (self.showStar) {
        [self drawStar];
    }
}



-(UIBezierPath *)drawWavePath:(CGFloat)height width:(CGFloat)width centerX:(CGFloat)x
{
    UIBezierPath *path = [[UIBezierPath alloc] init];
    for (int i = 1; i <= self.number; i++) {
        CGFloat y = [self originOfSymbolAtIndex:i];
        CGPoint myPoint = CGPointMake(x, y);
        [path moveToPoint:myPoint];
        CGPoint helperPoint1 = CGPointMake(x+width/4.0, y - height);
        CGPoint helperPoint2 = CGPointMake(x+width/4.0*3.0, y + height/2);
        CGPoint endPoint = CGPointMake(x + width, y);
        [path addCurveToPoint:endPoint controlPoint1:helperPoint1 controlPoint2:helperPoint2];
        helperPoint1.y = y;
        helperPoint2.y = y + height;
        [path addCurveToPoint:myPoint controlPoint1:helperPoint2 controlPoint2:helperPoint1];
    }
    return path;
}

-(UIBezierPath *)drawDiamondPath:(CGFloat)height width:(CGFloat)width centerX:(CGFloat)x
{
    
    UIBezierPath *path = [[UIBezierPath alloc] init];
    for (int i = 1; i <= self.number; i++) {
        CGFloat y = [self originOfSymbolAtIndex:i];
        CGPoint myPoint = CGPointMake(x, y);
        [path moveToPoint:myPoint];
        CGPoint point1 = CGPointMake(x+width/2.0, y - height/2.0);
        CGPoint point2 = CGPointMake(x+width, y);
        CGPoint point3 = CGPointMake(x + width/2.0, y+height/2.0);
        [path addLineToPoint:point1];
        [path addLineToPoint:point2];
        [path addLineToPoint:point3];
        [path closePath];
    }
    return path;
}


#define  CORNER_FONT_STANDART_HEIGHT 180.0
#define CORNER_RADIUS 12.0

-(CGFloat)cornerScaleFactor {return self.bounds.size.height /CORNER_FONT_STANDART_HEIGHT; };
-(CGFloat)cornerRadius { return CORNER_RADIUS * [self cornerScaleFactor]; };
-(CGFloat)cornerOffset {return [self cornerRadius] / 3.0; };

-(void)drawStar
{
    CGPoint center = CGPointMake([self cornerOffset], [self cornerOffset]);
    
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    CGContextSaveGState(currentContext);
    CGContextSetShadow(currentContext, CGSizeMake(4,7), 3);
    UIImage *star = [UIImage imageNamed:@"star.png"];
    CGRect secondFrame = CGRectMake(center.x/2.0, center.y/2.0, 6*center.x, 6*center.y);
    [star drawInRect:secondFrame];
    CGContextRestoreGState(currentContext);
    
    //CGContextRelease(currentContext);
}

-(UIBezierPath *)drawOvalPath:(CGFloat)height width:(CGFloat)width centerX:(CGFloat)x
{
    UIBezierPath *path = [[UIBezierPath alloc] init];
    for (int i = 1; i <= self.number; i++) {
        CGFloat y = [self originOfSymbolAtIndex:i];
        CGPoint myPoint = CGPointMake(x, y-height/2.0);
        CGRect rect = CGRectMake(myPoint.x, myPoint.y, width, height);
        UIBezierPath  *path1 = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:[self cornerRadius]];
        [path appendPath:path1];
        //[path stroke];
    }
    return path;
}



-(CGFloat)originOfSymbolAtIndex:(int)index
{
    CGRect bounds = self.bounds;
    CGFloat d = bounds.size.height/(CGFloat)self.number;
    CGFloat y = d*index;
    y = y - d/2;
    return y;
}

-(CGPoint)sizeForSymbol
{
    CGFloat width = self.bounds.size.width * 0.7;
    CGFloat height = self.bounds.size.height/6;
    return CGPointMake(width, height);
}
-(UIColor *)colorAsInt:(NSUInteger)index
{
    NSArray *colorTable = [NSArray arrayWithObjects:[UIColor greenColor],[UIColor blueColor], [UIColor purpleColor], nil];
    if (index > 0 && index <= 3) {
        return colorTable[index-1];
    }
    NSLog(@"Exception");
    return nil;
    
}

-(void)setStripes:(UIBezierPath *)path
{
    CGRect bounds = self.bounds;
    UIBezierPath *stripes = [UIBezierPath bezierPath];
    for ( int x = 0; x < bounds.size.width; x += 5 )
    {
        [stripes moveToPoint:CGPointMake( bounds.origin.x + x, bounds.origin.y )];
        [stripes addLineToPoint:CGPointMake( bounds.origin.x + x, bounds.origin.y + bounds.size.height )];
    }
    [stripes setLineWidth:3];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // draw the fill pattern first, using the outline to clip
    CGContextSaveGState( context );         // save the graphics state
    [path addClip];                        // use the outline as the clipping path
    [[self colorAsInt:self.color] setStroke];              // blue color for vertical stripes
    [stripes stroke];                       // draw the stripes
    CGContextRestoreGState( context );      // restore the graphics state, removes the clipping path
    
}
    













@end
