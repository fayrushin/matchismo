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



@property(strong, nonatomic) Deck *myDeck;
@property (weak, nonatomic) IBOutlet UIView *placeForDeck;
@property (strong,nonatomic) NSMutableArray *cardViews;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@end

@implementation ViewController

#pragma mark - View life Cycle
- (void) viewDidLoad
{
    [super viewDidLoad];
}



#pragma mark - Properties
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

#pragma mark - Actions
- (IBAction)redealButton:(UIButton *)sender
{
    NSInteger savingGameModeOfOldGame = self.game.gameMode;
    self.game = [[CardMatchingGame alloc] initWithCardCount:self.cardCount usingDeck:[self createDeck]];
    self.game.gameMode = savingGameModeOfOldGame;
    [self updateUI];
    
}

- (IBAction)touchCardButton:(UIButton *)sender
{
    
    NSInteger chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex];
    [self updateUI];
    
}

- (void) updateUI
{
    for (UIButton *cardButton in self.cardButtons) {
        NSInteger cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setAttributedTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", self.game.score];
    }
    

}

#pragma mark - Utilities
- (NSAttributedString *)titleForCardWithoutChecking:(Card *)card
{
    return [[NSAttributedString alloc] initWithString:card.contents];
}

- (NSAttributedString *)titleForCard:(Card *)card
{
    NSAttributedString *title = [[NSAttributedString alloc]
                                 initWithString:card.isChosen ? [[self titleForCardWithoutChecking:card] string] : @""];
    return title;
}

- (UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}

@end
