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
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;




@end

@implementation ViewController

-(NSArray *)history
{
    if (!_history) {
        _history = [[NSMutableArray alloc] init];
    }
    return _history;
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    self.game.gameMode = 2;
}
- (IBAction)redealButton:(UIButton *)sender
{
    NSInteger savingGameModeOfOldGame = self.game.gameMode;
    self.game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck]];
    self.game.gameMode = savingGameModeOfOldGame;
    [self updateUI];
    self.history = [[NSMutableArray alloc] init];
    
}

- (CardMatchingGame *)game
{
    if (!_game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck]];
    }
    return _game;
}
- (Deck *)createDeck
{
    return nil;
}

- (IBAction)touchCardButton:(UIButton *)sender
{
    NSMutableAttributedString *cardsContent = [[NSMutableAttributedString alloc] init];
    for (int i = 0; i < [self.cardButtons count]; i++) {
        Card *myCard = [self.game cardAtIndex:i];
        if (!myCard.isMatched && myCard.isChosen) {
            NSAttributedString *text = [self titleForCard:myCard];
            [cardsContent appendAttributedString:text];
        }
    }
    NSInteger chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex];
    
    NSMutableAttributedString *myText;
    
    if (self.game.matching) {
        NSAttributedString *text = [self titleForCardWithoutChecking:[self.game cardAtIndex:chosenButtonIndex]];
        if (self.game.pointForLastMatch > 0)
            myText = [[NSMutableAttributedString alloc] initWithString:@"Matched "];
        else myText = [[NSMutableAttributedString alloc] init];
        [myText appendAttributedString:text];
        
        [myText appendAttributedString:cardsContent];
        NSString *text1;
        if (self.game.pointForLastMatch > 0){
            text1 = [NSString stringWithFormat:@" for %ld points.", self.game.pointForLastMatch];
        }
        
        else {
            text1 = [NSString stringWithFormat:@" don't match! %ld point penalty!", -self.game.pointForLastMatch];
        }

        [myText appendAttributedString:[[NSAttributedString alloc] initWithString:text1]];
        [self.history addObject:myText];
        
    }
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
