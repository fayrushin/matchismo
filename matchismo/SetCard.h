//
//  SetCard.h
//  matchismo
//
//  Created by Равил Файрушин on 17.08.15.
//  Copyright (c) 2015 Равил Файрушин. All rights reserved.
//

#import "Card.h"
#import <UIKit/UIKit.h>

@interface SetCard : Card

@property (nonatomic) NSUInteger number;
@property (nonatomic,strong) NSString *symbol;
@property (nonatomic,strong) NSString *shading;
@property (nonatomic, strong) NSString *color;

+(NSArray *)validSymbols;
+(NSArray *)validShadings;
+(NSArray *)validColors;
+(NSUInteger)maxNumber;

@end
