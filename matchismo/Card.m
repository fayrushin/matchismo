//
//  Card.m
//  matchingCards1
//
//  Created by Равил Файрушин on 12.08.15.
//  Copyright (c) 2015 Равил Файрушин. All rights reserved.
//

#import "Card.h"
@interface Card()

@end

@implementation Card


-(int)match:(NSArray *)otherCards
{
    int score = 0;
    for (Card *card in otherCards) {
        if ([card.contents isEqualToString:self.contents]) {
            score = 1;
        }
    }
    return score;
}

@end
