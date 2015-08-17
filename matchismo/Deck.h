//
//  Deck.h
//  matchingCards1
//
//  Created by Равил Файрушин on 12.08.15.
//  Copyright (c) 2015 Равил Файрушин. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject
-(void)addCard:(Card *) card atTop:(BOOL)atTop;
-(void)addCard:(Card *) card;

-(Card *)drawRandomCard;

@end
