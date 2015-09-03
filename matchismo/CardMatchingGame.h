//
//  CardMatchingGame.h
//  matchismo
//
//  Created by Равил Файрушин on 17.08.15.
//  Copyright (c) 2015 Равил Файрушин. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "Card.h"


@interface CardMatchingGame : NSObject

//designated initializer
- (instancetype)initWithCardCount: (NSUInteger)count usingDeck:(Deck *)deck;

- (void)chooseCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;
- (void)addCardFromDeckToIndex:(NSUInteger)index;
- (NSUInteger)numberOfCardsInDeck;
- (void)moveLastCardToIndex:(NSUInteger) index;
- (void)removeCardAtIndex:(NSUInteger) index;

@property (nonatomic) NSInteger score;
@property (nonatomic) NSInteger gameMode;
@property (nonatomic, readonly) NSUInteger cardsInPlay;





@end
