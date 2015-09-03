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



@interface SetGameViewController () <UIGestureRecognizerDelegate>

@property (strong,nonatomic) UIView *SetCardView;
@property (nonatomic) BOOL showingHints;

@end

@implementation SetGameViewController

#pragma mark - View life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.game.gameMode = 3;
}

#pragma mark - Properties

-(void)setShowingHints:(BOOL)showingHints
{
    _showingHints = showingHints;
    if (!showingHints) {
        for (SetCardView *view in self.cardViews) {
            view.showStar = NO;
        }
    }
}

#pragma mark - Utilities

-(void)showHint
{
    int score = 0;
    int i,j,k;
    for (i = 0; i < self.game.cardsInPlay-2 && !score; i++) {
        Card *card = [self.game cardAtIndex:i];
        NSMutableArray *otherCards = [NSMutableArray array];
        for (j = i+1; j < self.game.cardsInPlay-1 && !score; j++) {
            if ([otherCards count])
                [otherCards removeAllObjects];
            [otherCards addObject:[self.game cardAtIndex:j]];
            for (k = j+1; k < self.game.cardsInPlay && !score; k++) {
                if([otherCards count] ==2)
                    [otherCards removeLastObject];
                [otherCards addObject:[self.game cardAtIndex:k]];
                score = [card match:otherCards];
                
            }
            
        }
        
    }
    if (score) {
        ((SetCardView *)self.cardViews[i-1]).showStar = YES;
        ((SetCardView *)self.cardViews[j-1]).showStar = YES;
        ((SetCardView *)self.cardViews[k-1]).showStar = YES;
        self.game.score -=3;
        [self updateUI];
    }
    
}

-(UIView *)createViewOfCard:(Card *)card atNumber:(int)number
{
    SetCardView *cardView = [[SetCardView alloc] initWithFrame:[self boundSizeForCard]];
    SetCard *myCard = (SetCard *)card;
    [cardView setCardFeatures:myCard];
    cardView.tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hlip:)];
    [cardView addGestureRecognizer:cardView.tap];
    cardView.pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    cardView.pan.delegate = self;
    [cardView addGestureRecognizer:cardView.pan];
    
    return cardView;
}

- (void) updateUI
{
    [super updateUI];
    for (int i = 0; i < [self.cardViews count]; i++) {
        SetCardView *cardView = self.cardViews[i];

        Card *card = [self.game cardAtIndex:i];
        if (card.isChosen) {
            cardView.choosen = YES;
        }
        else cardView.choosen = NO;
        
    }
    
    [self animateReShuffle:self.cardViews];
    
}

#pragma mark - Actions

- (IBAction)showHintButton:(UIButton *)sender
{
    if (!self.showingHints) [self showHint];
}


- (IBAction)redealButton:(UIButton *)sender
{
    self.showingHints = NO;
    for (int i = 0; i < [self.cardViews count]; i++) {
        SetCardView *view = self.cardViews[i];
        [self animateRemovingCards:view];
        [view removeGestureRecognizer:view.tap];
    }
    [super redealButton:sender];
    self.game.gameMode = 3;
    
}
-(void)hlip:(UITapGestureRecognizer *)gesture
{
    self.showingHints = NO;
    [super hlip:gesture];
    if (self.game.cardsInPlay < self.cardCount) {
        for (int i = 0; i<[self.cardViews count]; i++) {
            SetCardView *cardView = self.cardViews[i];
            Card *card = [self.game cardAtIndex:i];
            if (card.isMatched) {
                [self.game addCardFromDeckToIndex:i];
                [self animateRemovingCards:cardView];
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
            Card *card = [self.game cardAtIndex:i];
            if (card.isMatched) {
                [self animateRemovingCards:cardView];
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
- (IBAction)addCardsButton:(UIButton *)sender
{
    self.showingHints = NO;
    if (self.game.numberOfCardsInDeck >= self.game.gameMode &&
        self.game.cardsInPlay < MAX_NUMBER_OF_CARDS_IN_VIEW) {
        self.rows ++;
        [self updateUI];
        for (int i = 0; i < self.game.gameMode; i++) {
            [self.game addCardFromDeckToIndex:self.game.cardsInPlay];
            Card *card = [self.game cardAtIndex:self.game.cardsInPlay-1];
            UIView *view = [self createViewOfCard:card atNumber:(int)self.game.cardsInPlay];
            CGRect frame = view.frame;
            frame.origin.x = self.placeForDeck.bounds.size.height;
            frame.origin.y = self.placeForDeck.bounds.size.width;
            view.bounds = frame;
            [self.placeForDeck addSubview:view];
            [self.cardViews addObject:view];
            [self animateAddingCard:view];
        }
        
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
