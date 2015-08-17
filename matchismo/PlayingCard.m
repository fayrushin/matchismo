//
//  PlayingCard.m
//  matchingCards1
//
//  Created by Равил Файрушин on 12.08.15.
//  Copyright (c) 2015 Равил Файрушин. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

-(int) match:(NSArray *)otherCards
{
    int score = 0;
    
    if ([otherCards count] == 1) {
        PlayingCard *otherCard = [otherCards firstObject];
        if (otherCard.rank == self.rank) {
            score = 4;
        } else if ([otherCard.suit isEqualToString:self.suit]) {
            score = 1;
        }
    }
    else
    {
        int scoreByRank = 0;
        int scoreBySuit = 0;
        for (PlayingCard *otherCard in otherCards) {
            if (otherCard.rank == self.rank) {
                scoreByRank ++;
            } else if ([otherCard.suit isEqualToString:self.suit])
                scoreBySuit ++;
        }
        int score1 = 0;
        int score2 = 0;
        for (int i = 0; i < [otherCards count] - 1; i++) {
            for (int j = i + 1; j < [otherCards count]; j++) {
                if ([otherCards[i] rank] == [otherCards[j] rank]) {
                    score1++;
                }
                else if ([[otherCards[i] suit] isEqualToString:[otherCards[j] suit]])
                    score2 ++;
            }
            scoreByRank = score1 > scoreByRank ? score1 : scoreByRank;
            scoreBySuit = score2 > scoreBySuit ? score2 : scoreBySuit;
        
        }
        score = scoreByRank * 4 + scoreBySuit;
    }
    return score;
}



-(NSString *)contents
{
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

@synthesize  suit = _suit;

+ (NSArray *)validSuits
{
    return @[@"♥",@"♦",@"♠",@"♣"];
}

-(void)setSuit:(NSString *)suit
{
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

-(NSString *)suit
{
    return  _suit ? _suit: @"?";
}

+(NSArray *)rankStrings
{
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

+(NSUInteger) maxRank {return [[self rankStrings] count]-1; }

-(void)setRank:(NSUInteger)rank
{
    if(rank <= [PlayingCard maxRank]) {
        _rank =rank;
    }
}
@end
