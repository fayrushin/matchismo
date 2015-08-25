//
//  ViewController.m
//  matchismo
//
//  Created by Равил Файрушин on 17.08.15.
//  Copyright (c) 2015 Равил Файрушин. All rights reserved.
//

#import "ViewController.h"
//#import "CardMatchingGame.h"

@interface ViewController ()


@end

@implementation ViewController

#pragma mark - View life Cycle
- (void) viewDidLoad
{
    
    [super viewDidLoad];
    [self setRowsColumns];
    [self addCardViewsToCollection];
    for (int i = 0; i < self.cardCount; i++) {
        
        UIView *cardView = self.cardViews[i];
        
        CGRect myFrame = cardView.frame;
        myFrame.origin = [self originForCard:i];
        cardView.frame = myFrame;
        cardView.bounds = [self boundSizeForCard];
        self.cardViews[i] = cardView;
        [self.placeForDeck addSubview:cardView];
        
        
    }
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
}
-(void)viewDidLayoutSubviews
{
    for (int i = 0; i < self.game.cardsInPlay; i++) {
        
        UIView *cardView = self.cardViews[i];
        
        CGRect myFrame = cardView.frame;
        myFrame.origin = [self originForCard:i];
        cardView.frame = myFrame;
        cardView.bounds = [self boundSizeForCard];
        
        //[self.placeForDeck addSubview:cardView];
        
    }
    
}



#pragma mark - Properties

-(NSInteger)cardCount
{
    if (!_cardCount) {
        _cardCount = 30;
    }
    return _cardCount;
}
- (CardMatchingGame *)game
{
    if (!_game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:self.cardCount usingDeck:[self createDeck]];
    }
    return _game;
}
- (Deck *)createDeck
{
    return nil;
}

-(NSMutableArray *)cardViews
{
    if (!_cardViews) {
        _cardViews = [[NSMutableArray alloc] init];
    }
    return _cardViews;
}
-(void)addCardViewsToCollection
{
    for (int i = 0; i < self.cardCount; i++) {
        UIView *cardView = [self createViewOfCard:[self.game cardAtIndex:i] atNumber:i];
        [self.cardViews addObject:cardView];
    }
}

-(UIView *)createViewOfCard:(Card *)card atNumber:(int)number;
{
    return nil;
}



#pragma mark - Actions

-(void)hlip:(UITapGestureRecognizer *)gesture
{
    UIView *view = gesture.view;
    NSInteger choosenCardIndex = [self.cardViews indexOfObject:view];
    [self.game chooseCardAtIndex:choosenCardIndex];
    [self updateUI];
}

- (IBAction)redealButton:(UIButton *)sender
{
    
    self.game = nil;
    self.cardViews = nil;
    self.cardViews = [[NSMutableArray alloc] init];
    self.game = [[CardMatchingGame alloc] initWithCardCount:self.cardCount usingDeck:[self createDeck]];
    [self setRowsColumns];
    [self addCardViewsToCollection];
    for (int i = 0; i < self.cardCount; i++) {
        
        UIView *cardView = self.cardViews[i];
        
        CGRect myFrame = cardView.frame;
        myFrame.origin = [self originForCard:i];
        cardView.frame = myFrame;
        self.cardViews[i] =cardView;
        [self.placeForDeck addSubview:cardView];
        
    }
    
    [self updateUI];
    
}


- (void) updateUI
{
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", self.game.score];


}

#pragma mark - Utilities

-(CGPoint)originForCard:(int) number
{
    CGFloat width = self.placeForDeck.bounds.size.width;
    CGFloat height = self.placeForDeck.bounds.size.height;
    int row = (number+1) / self.columns;
    int column = (number + 1) % self.columns;
    if (column) {
        row ++;
    }
    else column = self.columns;
    
    CGFloat x = (column - 1)/(CGFloat)self.columns * width;
    CGFloat y = (row - 1)/(CGFloat)self.rows * height;
    return CGPointMake(x, y);

}

-(CGRect)boundSizeForCard
{
    CGRect bounds = self.placeForDeck.bounds;
    CGRect cardBound;
    cardBound.origin = CGPointMake(0, 0);
    cardBound.size.width = bounds.size.width / self.columns * 0.7;
    cardBound.size.height = bounds.size.height / self.rows * 0.7;
    return cardBound;
}

-(void)setRowsColumns
{
    
}





@end
