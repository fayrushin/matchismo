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


@interface PlayingCardMGViewController ()
@property (weak, nonatomic) IBOutlet UIView *PlaceForDeckView;
@property (strong, nonatomic)PlayingCardView *playingCardView;

@end

@implementation PlayingCardMGViewController

#pragma mark - View life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    if (self) {
        CGRect bounds = self.PlaceForDeckView.bounds;
        CGRect cardBound = CGRectMake(bounds.origin.x, bounds.origin.y, bounds.size.width/6.0, bounds.size.height/6.0);
        self.playingCardView = [[PlayingCardView alloc] initWithFrame:cardBound];
        self.playingCardView.rank = 13;
        self.playingCardView.suit = @"♥︎";
        [self.PlaceForDeckView addSubview:self.playingCardView];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (Deck *)createDeck
{
    return [[PlayingCardDeck alloc] init];
}







@end
