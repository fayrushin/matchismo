//
//  ViewController.h
//  matchismo
//
//  Created by Равил Файрушин on 17.08.15.
//  Copyright (c) 2015 Равил Файрушин. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Deck.h"
#import "CardMatchingGame.h"

@interface ViewController : UIViewController

@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) NSMutableArray *history;

- (NSAttributedString *)titleForCard:(Card *)card;
- (UIImage *)backgroundImageForCard:(Card *)card;
- (void) updateUI;

- (Deck *)createDeck;


@end

