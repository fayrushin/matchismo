//
//  SetGameView.m
//  matchismo
//
//  Created by Равил Файрушин on 19.08.15.
//  Copyright (c) 2015 Равил Файрушин. All rights reserved.
//

#import "SetCardView.h"

@interface SetCardView()

@property(nonatomic) NSUInteger color;
@property(nonatomic) NSUInteger symbol;
@property(nonatomic) NSUInteger shading;
@property(nonatomic) NSUInteger number;

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


-(void)setCardFeatures:(SetCard *)card
{
    self.color = card.color;
    self.symbol = card.symbol;
    self.shading = card.shading;
    self.number = card.number;
    [self setNeedsDisplay];
    
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //NSLog(@"%@ was touched", self);
}


-(void) drawRect:(CGRect)rect
{
    CGRect bounds = self.bounds;
    CGPoint center;
    center.x = bounds.origin.x + bounds.size.width/2.0;
    center.y = bounds.origin.y + bounds.size.height/2.0;
    
    UIBezierPath *path = [[UIBezierPath alloc] init];
    CGPoint myPoint = CGPointMake(center.x - 25, center.y);
    int x = myPoint.x;
    myPoint.y = ((bounds.size.height/12) * sin((( (x+27)*10) % 360) * M_PI/180))+100;
    [path moveToPoint: myPoint];
    
    
    for (x = myPoint.x; x <= center.x + 25; x++) {
        myPoint.y = ((bounds.size.height/12) * sin((((x+27)*10) % 360) * M_PI/180))+100;
        myPoint.x = x;
        [path addLineToPoint:myPoint];
    }
    [[UIColor redColor] setStroke];
    path.lineWidth = 3;
    [path stroke];
    
}
@end
