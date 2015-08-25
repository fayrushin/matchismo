//
//  SetGameViewController.m
//  matchismo
//
//  Created by Равил Файрушин on 17.08.15.
//  Copyright (c) 2015 Равил Файрушин. All rights reserved.
//

#import "SetGameViewController.h"
#import "SetCardDeck.h"
#import "SetCard.h"
#import "SetCardView.h"



@interface SetGameViewController ()

@property (strong,nonatomic) UIView *SetCardView;

@end

@implementation SetGameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.game.gameMode = 3;

    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(UIView *)createViewOfCard:(Card *)card atNumber:(int)number
{
    SetCardView *cardView = [[SetCardView alloc] initWithFrame:[self boundSizeForCard]];
    SetCard *myCard = (SetCard *)card;
    [cardView setCardFeatures:myCard];
    cardView.tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hlip:)];
    [cardView addGestureRecognizer:cardView.tap];
    
    return cardView;
}

- (void) updateUI
{
    [super updateUI];
    for (int i = 0; i < [self.cardViews count]; i++) {
        Card *card = [self.game cardAtIndex:i];
        SetCardView *cardView = self.cardViews[i];
        
        CGRect myFrame = cardView.frame;
        myFrame.origin = [self originForCard:i];
        cardView.frame = myFrame;
        cardView.bounds = [self boundSizeForCard];
        self.cardViews[i] = cardView;
        
        if (card.isChosen) {
            cardView.choosen = YES;
        }
        else cardView.choosen = NO;
        if (card.isMatched) {
            cardView.hidden = YES;
        }
                
    }
    
}
- (IBAction)redealButton:(UIButton *)sender
{
    for (int i = 0; i < [self.cardViews count]; i++) {
        SetCardView *view = self.cardViews[i];
        [view removeGestureRecognizer:view.tap];
        [view removeFromSuperview];
    }
    [super redealButton:sender];
    self.game.gameMode = 3;
    
}
-(void)hlip:(UITapGestureRecognizer *)gesture
{
    [super hlip:gesture];
    if (self.game.cardsInPlay < self.cardCount) {
        for (int i = 0; i<[self.cardViews count]; i++) {
            SetCardView *cardView = self.cardViews[i];
            Card *card = [self.game cardAtIndex:i];
            if (card.isMatched) {
                [self.game addCardFromDeckToIndex:i];
                [cardView removeFromSuperview];
                [cardView removeGestureRecognizer:cardView.tap];
                cardView = (SetCardView *)[self createViewOfCard:[self.game cardAtIndex:i] atNumber:i];
                [self.placeForDeck addSubview:cardView];
                self.cardViews[i]=cardView;
                
            }
        }
    }
    else if(self.game.cardsInPlay < [self.cardViews count])
    {
        int k = 0;
        for (int i = 0; i < [self.cardViews count]; i++) {
            SetCardView *cardView = self.cardViews[i];
            if (cardView.hidden) {
                [cardView removeFromSuperview];
                [cardView removeGestureRecognizer:cardView.tap];
                [self.cardViews removeObjectAtIndex:i];
                [self.game removeCardAtIndex:i];
                k++;
                i--;
            }
        }
        if(k>=3) self.rows --;
        
    }
    
    [self updateUI];
}
#define     MAX_NUMBER_OF_CARDS_IN_VIEW 18
- (IBAction)addCardsButton:(UIButton *)sender {
    if (self.game.numberOfCardsInDeck >= self.game.gameMode &&
        self.game.cardsInPlay < MAX_NUMBER_OF_CARDS_IN_VIEW) {
        for (int i = 0; i < self.game.gameMode; i++) {
            [self.game addCardFromDeckToIndex:self.game.cardsInPlay];
            Card *card = [self.game cardAtIndex:self.game.cardsInPlay-1];
            UIView *view = [self createViewOfCard:card atNumber:(int)self.game.cardsInPlay];
            [self.placeForDeck addSubview:view];
            
            [self.cardViews addObject:view];
        }
        self.rows ++;
    }
}

-(Deck *)createDeck
{
    return [[SetCardDeck alloc] init];
}

-(void)setRowsColumns
{
    self.columns = 3;
    self.rows = 4;
    self.cardCount = 12;
}




@end
