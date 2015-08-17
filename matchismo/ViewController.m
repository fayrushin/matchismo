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

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property(nonatomic) int flipCount;
@property(strong, nonatomic) Deck *myDeck;


@end

@implementation ViewController

-(Deck *)myDeck
{
    if (!_myDeck) {
        _myDeck = [[PlayingCardDeck alloc] init];
    }
    return  _myDeck;
}

-(void)setFlipCount:(int)flipCount {
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
}

- (IBAction)touchCardButton:(UIButton *)sender {
    
    if([sender.currentTitle length]) {
        [sender setBackgroundImage:[UIImage imageNamed:@"cardback"] forState:UIControlStateNormal];
        [sender setTitle:@"" forState:UIControlStateNormal];
        self.flipCount++;
        
    }
    else {
        Card *myCard = [self.myDeck drawRandomCard];
        if (myCard) {
            [sender setBackgroundImage:[UIImage imageNamed:@"cardfront"] forState:UIControlStateNormal];
            [sender setTitle:myCard.contents forState:UIControlStateNormal];
            self.flipCount++;
        }
        
    }
    
    NSLog(@"flipCount changed to %d", self.flipCount);
    
    
}

@end
