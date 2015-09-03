//
//  PlayingCardMGViewController.m
//  matchismo
//
//  Created by Равил Файрушин on 17.08.15.
//  Copyright (c) 2015 Равил Файрушин. All rights reserved.
//

#import "PlayingCardMGViewController.h"
#import "PlayingCardDeck.h"
#import "PlayingCardView.h"
#import "PlayingCard.h"

@interface PlayingCardMGViewController ()

@end

@implementation PlayingCardMGViewController

#pragma mark - View life cycle

- (Deck *)createDeck
{
    return [[PlayingCardDeck alloc] init];
}

-(UIView *)createViewOfCard:(Card *)card atNumber:(int)number
{
    
    PlayingCardView *cardView = [[PlayingCardView alloc] initWithFrame:[self boundSizeForCard]];
    cardView.rank = [(PlayingCardView *)card rank];
    cardView.suit = [(PlayingCardView *)card suit];
    cardView.tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hlip:)];
    [cardView addGestureRecognizer:cardView.tap];
    cardView.pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [cardView addGestureRecognizer:cardView.pan];

    return cardView;
}


- (void) updateUI
{
    [super updateUI];
    for (int i = 0; i < [self.cardViews count]; i++) {
        Card *card = [self.game cardAtIndex:i];
        PlayingCardView *cardView = self.cardViews[i];
        
         {
             if ( (card.isChosen && !cardView.faceUp) || (!card.isChosen && cardView.faceUp) ) {
                 [UIView transitionWithView:cardView duration:0.5 options:UIViewAnimationOptionTransitionFlipFromLeft
                                 animations:^{
                     if (card.isChosen)  cardView.faceUp = YES;
                     else cardView.faceUp = NO;
                     
                 }
                                 completion:nil];
             }
             if (card.isMatched && cardView.alpha == 1) {
                 [UIView transitionWithView:cardView duration:0.5 options:UIViewAnimationOptionBeginFromCurrentState
                                 animations:^{
                                     cardView.alpha = 0.5;
                                     
                                 }
                                 completion:nil];
                 
             }

         }
        
    }
    [self animateReShuffle:self.cardViews];

    
}
-(IBAction)redealButton:(UIButton *)sender
{
    for (int i = 0; i < [self.cardViews count]; i++) {
        PlayingCardView *view = self.cardViews[i];
        [view removeGestureRecognizer:view.tap];
        [self animateRemovingCards:view];
    }
    [super redealButton:sender];
    
}

- (void)setRowsColumns
{
    self.columns = 5;
    self.rows = 6;
    self.cardCount = 30;
}






@end
