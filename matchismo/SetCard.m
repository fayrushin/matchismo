//
//  SetCard.m
//  matchismo
//
//  Created by Равил Файрушин on 17.08.15.
//  Copyright (c) 2015 Равил Файрушин. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

-(void)setSymbol:(NSUInteger)symbol
{
    if (symbol <= [SetCard maxNumber])
        _symbol = symbol;
}


-(void)setShading:(NSUInteger)shading
{
    if (shading <= [SetCard maxNumber])
        _shading = shading;
}


-(void)setColor:(NSUInteger)color
{
    if (color <= [SetCard maxNumber])
        _color = color;
}

-(void) setNumber:(NSUInteger)number
{
    if (number <= [SetCard maxNumber]) {
        _number = number;
    }
}

+(NSUInteger)maxNumber
{
    return 3;
}
-(NSString *)contents
{
    return nil;
}
//#warning change return score
-(int)match:(NSArray *)otherCards
{
    int score = 0;
    NSMutableArray *color = [[NSMutableArray alloc] init];
    NSMutableArray *shading = [[NSMutableArray alloc] init];
    NSMutableArray *symbol = [[NSMutableArray alloc] init];
    NSMutableArray *number = [[NSMutableArray alloc] init];
    [color addObject:@(self.color)];
    [shading addObject:@(self.shading)];
    [symbol addObject:@(self.symbol)];
    [number addObject:@(self.number)];
    for (id otherCard in otherCards) {
        if ([otherCard isKindOfClass:[SetCard class]]) {
            SetCard *otherSetCard = (SetCard *) otherCard;
            if (![color containsObject:@(otherSetCard.color)])
                [color addObject:@(otherSetCard.color)];
            if (![shading containsObject:@(otherSetCard.shading)])
                [shading addObject:@(otherSetCard.shading)];
            if (![symbol containsObject:@(otherSetCard.symbol)])
                [symbol addObject:@(otherSetCard.symbol)];
            if (![number containsObject:@(otherSetCard.number)])
                [number addObject:@(otherSetCard.number)];
            
            
        }
    }
    if (([color count] == 1 || [color count] == 3 )
        && ([shading count] == 1 || [shading count] == 3)
        && ([symbol count] == 1 || [symbol count] == 3)
        && ([number count] == 1 || [number count] == 3))
        score = 4;
    return  score;
}

             
             
             
             
             
             
             
             
             
             

@end
