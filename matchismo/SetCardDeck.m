//
//  SetCardDeck.m
//  matchismo
//
//  Created by Равил Файрушин on 18.08.15.
//  Copyright (c) 2015 Равил Файрушин. All rights reserved.
//

#import "SetCard.h"
#import "SetCardDeck.h"

@implementation SetCardDeck
-(instancetype)init
{
    self = [super init];
    if (self) {
        for (NSString *color in [SetCard validColors]) {
            for (NSString *symbol in [SetCard validSymbols]) {
                for (NSString *shading in [SetCard validShadings]) {
                    for (NSUInteger number = 1; number <= [SetCard maxNumber]; number++) {
                        SetCard *card = [[SetCard alloc] init];
                        card.color = color;
                        card.symbol = symbol;
                        card.shading = shading;
                        card.number = number;
                        [self addCard:card atTop:YES];
                    }
                }
            }
        }
    }
    return self;
}

@end
