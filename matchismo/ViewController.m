//
//  ViewController.m
//  matchismo
//
//  Created by Равил Файрушин on 17.08.15.
//  Copyright (c) 2015 Равил Файрушин. All rights reserved.
//

#import "ViewController.h"
#import "PlayingCardDeck.h"
#import "Card.h"
#import "CardMatchingGame.h"

@interface ViewController ()



@property(strong, nonatomic) Deck *myDeck;
@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *gameModeControl;
@property (weak, nonatomic) IBOutlet UITextField *pointsText;


@end

@implementation ViewController

- (void) viewDidLoad
{
    self.game.gameMode = [self.gameModeControl selectedSegmentIndex] + 2;
}
- (IBAction)redealButton:(UIButton *)sender
{
    self.gameModeControl.enabled = YES;
    self.game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck]];
    self.game.gameMode = self.gameModeControl.selectedSegmentIndex + 2;

    [self updateUI];
    self.pointsText.text = @"";
}
- (IBAction)gameModeSwitch:(UISegmentedControl *)sender {
    self.game.gameMode = sender.selectedSegmentIndex + 2;
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
    return [[PlayingCardDeck alloc] init];
}

- (IBAction)touchCardButton:(UIButton *)sender
{
    self.gameModeControl.enabled = NO;
    NSInteger chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex];
    
    NSString *myText = [NSString string];
    
    if (self.game.matching) {
        if (self.game.pointForLastMatch > 0) {
            myText = [NSString stringWithFormat:@"Matched %@", [self.game cardAtIndex:chosenButtonIndex].contents];

        }
        else myText = [self.game cardAtIndex:chosenButtonIndex].contents;
        for (UIButton *cardButton in self.cardButtons) {
            if (cardButton.enabled) {
                myText = [myText stringByAppendingString:cardButton.currentTitle];

            }
        }
        if (self.game.pointForLastMatch > 0) {
            NSString *text = [NSString stringWithFormat:@" for %ld points.", self.game.pointForLastMatch];
            myText = [myText stringByAppendingString:text];
        }
        else {
            NSString *text = [NSString stringWithFormat:@" don't match! %ld point penalty!", -self.game.pointForLastMatch];
            myText = [myText stringByAppendingString:text];
        }
    }
    else {
        if ([sender.currentTitle length]) myText = @"";
        else myText = [self.game cardAtIndex:chosenButtonIndex].contents;
    }
    self.pointsText.text = myText;
    
    [self updateUI];
}

- (void) updateUI
{
    for (UIButton *cardButton in self.cardButtons) {
        NSInteger cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", self.game.score];
    }
    

}

- (NSString *)titleForCard:(Card *)card
{
    return card.isChosen ? card.contents : @"";
}

- (UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}

@end
