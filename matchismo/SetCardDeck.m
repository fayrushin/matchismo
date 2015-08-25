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
        for (NSUInteger i = 1; i <= [SetCard maxNumber]; i++) {
            for (NSUInteger j = 1; j <= [SetCard maxNumber]; j++) {
                for (NSUInteger k = 1; k <= [SetCard maxNumber]; k++) {
                    for (NSUInteger number = 1; number <= [SetCard maxNumber]; number++) {
                        SetCard *card = [[SetCard alloc] init];
                        card.color = i;
                        card.symbol = j;
                        card.shading = k;
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
