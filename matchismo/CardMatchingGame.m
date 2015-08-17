//
//  CardMatchingGame.m
//  matchismo
//
//  Created by Равил Файрушин on 17.08.15.
//  Copyright (c) 2015 Равил Файрушин. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards;
@property (nonatomic,readwrite) NSInteger pointForLastMatch;
@property (nonatomic, readwrite) BOOL matching;
@property (nonatomic) NSInteger numberOfChosenCards;

@end

@implementation CardMatchingGame

- (NSMutableArray *) cards
{
    if(!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck
{
    self = [super init];
    self.numberOfChosenCards = 0;
    if (self) {
        for (int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if (card) {
                [self.cards addObject:card];
            } else {
                self = nil;
                break;
            }
        }
    }
    return self;
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index<[self.cards count]) ? self.cards[index] : nil;
}

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

- (void)chooseCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    self.matching = NO;
    
    /*
    if (!card.isMatched) {
        if (card.isChosen) {
            card.chosen = NO;
        } else {
            //match against other chosen cards
            for (Card *otherCard in self.cards) {
                if (otherCard.isChosen && !otherCard.isMatched) {
                    int matchScore = [card match:@[otherCard]];
                    if (matchScore) {
                        self.score += matchScore * MATCH_BONUS;
                        otherCard.matched = YES;
                        card.matched = YES;
                    } else {
                        self.score -= MISMATCH_PENALTY;
                        otherCard.chosen = NO;
                    }
                    break;
                }
            }
            self.score -= COST_TO_CHOOSE;
            card.chosen = YES;
        }
    }*/
    
    if (!card.isMatched) {
        if (card.isChosen) {
            card.chosen = NO;
            self.numberOfChosenCards --;
        }
        else
        {
            self.numberOfChosenCards ++;
            if (self.numberOfChosenCards == self.gameMode) {
                self.matching = YES;
                NSMutableArray *anotherCards = [[NSMutableArray alloc] init];
                for (Card *otherCard in self.cards) {
                    if (otherCard.isChosen && !otherCard.isMatched) {
                        [anotherCards addObject:otherCard];
                    }
                }
                int matchScore = [card match:anotherCards];
                if (matchScore) {
                    self.pointForLastMatch = matchScore * MATCH_BONUS;
                    self.score += self.pointForLastMatch;
                    for (Card *otherCard in anotherCards) {
                        otherCard.matched = YES;
                    }
                    card.matched = YES;
                    self.numberOfChosenCards = 0;
                }
                else
                {
                    self.pointForLastMatch = - MISMATCH_PENALTY;
                    self.score -= MISMATCH_PENALTY;
                    for (Card *otherCard in anotherCards) {
                        otherCard.chosen = NO;
                    }
                    self.numberOfChosenCards = 1;
                }
            }
            self.score -= COST_TO_CHOOSE;
            card.chosen = YES;
        }
        
    }
    
    
    
    
    
    
    
    
    
    
    
}


@end
