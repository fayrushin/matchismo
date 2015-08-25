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

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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
                 [UIView transitionWithView:cardView duration:0.2 options:UIViewAnimationOptionTransitionFlipFromLeft
                                 animations:^{
                     if (card.isChosen)  cardView.faceUp = YES;
                     else cardView.faceUp = NO;
                     
                 }
                                 completion:nil];
             }

             }
         }
    
}
-(IBAction)redealButton:(UIButton *)sender
{
    for (int i = 0; i < [self.cardViews count]; i++) {
        PlayingCardView *view = self.cardViews[i];
        [view removeGestureRecognizer:view.tap];
        [view removeFromSuperview];
    }
    [super redealButton:sender];
    
}

- (void)setRowsColumns
{
    self.columns = 3;
    self.rows = 5;
    self.cardCount = 15;
}






@end
