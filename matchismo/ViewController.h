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
@property (nonatomic) NSInteger cardCount;
@property (weak, nonatomic) IBOutlet UIView *placeForDeck;
@property (strong,nonatomic) NSMutableArray *cardViews;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;



@property (nonatomic)int columns;
@property (nonatomic)int rows;
- (void) updateUI;
-(UIView *)createViewOfCard:(Card *)card atNumber:(int)number;
-(void)hlip:(UITapGestureRecognizer *)gesture;
-(CGPoint)originForCard:(int) number;
-(CGRect)boundSizeForCard;
-(void)setRowsColumns;
- (IBAction)redealButton:(UIButton *)sender;


- (Deck *)createDeck;


@end

