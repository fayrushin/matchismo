//
//  CardMatchingGame.m
//  matchismo
//
//  Created by Равил Файрушин on 17.08.15.
//  Copyright (c) 2015 Равил Файрушин. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (nonatomic, strong) NSMutableArray *cards;
@property (nonatomic) NSInteger numberOfChosenCards;
@property (nonatomic,strong) Deck *gameDeck;
@property (nonatomic,readwrite) NSUInteger cardsInPlay;

@end

@implementation CardMatchingGame

- (void)removeCardAtIndex:(NSUInteger) index
{
    if (index < [self.cards count]) {
        [self.cards removeObjectAtIndex:index];
    }
}

- (void)moveLastCardToIndex:(NSUInteger) index
{
    if (index < [self.cards count]) {
        self.cards[index] = [self.cards lastObject];
        [self.cards removeLastObject];
    }
}


- (NSUInteger)numberOfCardsInDeck
{
    return self.gameDeck.cardsInDeck;
}

- (void)addCardFromDeckToIndex:(NSUInteger)index
{
    Card *card = [self.gameDeck drawRandomCard];
    if (card) {
        if(index >= [self.cards count]){
            [self.cards addObject:card];
        }
        else self.cards[index] = card;
        
        self.cardsInPlay ++;
    }
    else NSLog(@"inserting to wrong index");
}

- (NSMutableArray *) cards
{
    if(!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck
{
    self = [super init];
    
    if (self) {
        self.numberOfChosenCards = 0;
        self.cardsInPlay = count;
        self.gameDeck = deck;
        self.gameMode = 2;
        for (int i = 0; i < count; i++) {
            Card *card = [self.gameDeck drawRandomCard];
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
    
    if (!card.isMatched) {
        if (card.isChosen) {
            card.chosen = NO;
            self.numberOfChosenCards --;
        }
        else
        {
            self.numberOfChosenCards ++;
            if (self.numberOfChosenCards == self.gameMode) {
                NSMutableArray *anotherCards = [[NSMutableArray alloc] init];
                for (Card *otherCard in self.cards) {
                    if (otherCard.isChosen && !otherCard.isMatched) {
                        [anotherCards addObject:otherCard];
                    }
                }
                int matchScore = [card match:anotherCards];
                if (matchScore) {
                    self.score += matchScore * MATCH_BONUS;
                    for (Card *otherCard in anotherCards) {
                        otherCard.matched = YES;
                        self.cardsInPlay --;
                    }
                    self.cardsInPlay -= 1;
                    card.matched = YES;
                    self.numberOfChosenCards = 0;
                }
                else
                {
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
