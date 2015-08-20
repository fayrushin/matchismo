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
    [self updateUI];
    
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    if (self) {
        CGRect screenRect = self.view.bounds;
        screenRect.size.height /= 3;
        screenRect.size.width /=3;
        screenRect.origin.y = screenRect.size.height;
        screenRect.origin.x =screenRect.size.width;
        self.SetCardView = [[SetCardView alloc] initWithFrame:screenRect];
        [self.view addSubview:self.SetCardView];
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(Deck *)createDeck
{
    return [[SetCardDeck alloc] init];
}

- (UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:card.isChosen ? @"setCardSelected" : @"setCard"];
}

- (NSAttributedString *)titleForCardWithoutChecking:(Card *)card
{
    NSString *symbol = @"?";
        return [[NSMutableAttributedString alloc] initWithString:symbol];
}

- (NSAttributedString *)titleForCard:(Card *)card
{
    return [self titleForCardWithoutChecking:card];
    
}



@end
