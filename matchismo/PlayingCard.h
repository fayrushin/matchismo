//
//  PlayingCard.h
//  matchingCards1
//
//  Created by Равил Файрушин on 12.08.15.
//  Copyright (c) 2015 Равил Файрушин. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+(NSArray *)validSuits;
+(NSUInteger)maxRank;

@end
