//
//  ViewController.m
//  matchismo
//
//  Created by Равил Файрушин on 17.08.15.
//  Copyright (c) 2015 Равил Файрушин. All rights reserved.
//

#import "ViewController.h"
//#import "CardMatchingGame.h"

@interface ViewController () <UIDynamicAnimatorDelegate>
@property (strong, nonatomic) NSMutableArray *attachments;
@property (strong, nonatomic) UIDynamicAnimator *animator;



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
        [self.placeForDeck addSubview:cardView];
    }
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    for (int i = 0; i < self.cardCount; i++) {
        
        UIView *cardView = self.cardViews[i];
        
        CGRect myFrame = cardView.frame;
         myFrame.origin = CGPointZero;
         cardView.frame = myFrame;
        self.cardViews[i] = cardView;
    }
    [self animateReShuffle:self.cardViews];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self removeAttachments];
}
-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self animateReShuffle:self.cardViews];
    
}



#pragma mark - Properties

-(NSMutableArray *)attachments
{
    if (!_attachments) {
        _attachments = [[NSMutableArray alloc] init];
    }
    return _attachments;
}

- (UIDynamicAnimator *)animator
{
    if (!_animator) {
        _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.placeForDeck];
        _animator.delegate = self;
    }
    return _animator;
}

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



- (IBAction)pinch:(UIPinchGestureRecognizer *)sender
{
    if (![self.attachments count]) {
        [self attachCardViewsToPoint:self.placeForDeck.center];
    }
    if (sender.state == UIGestureRecognizerStateChanged)
    {
        [self resizeDistanceToAnchor:sender.scale];
        sender.scale = 1;
    }
}

-(void)pan:(UIPanGestureRecognizer *)gr
{
    if(gr.state == UIGestureRecognizerStateChanged) {
        CGPoint point = [gr locationInView:self.placeForDeck];
        for (int i = 0; i<[self.attachments count]; i++) {
            UIAttachmentBehavior *attachment = self.attachments[i];
            attachment.anchorPoint = point;
            self.attachments[i] =attachment;
        }
    }
}

-(void)resizeDistanceToAnchor:(CGFloat)scale
{
    
    if (scale < 1) {
        for (int i = 0; i < [self.attachments count]; i++) {
            CGPoint center = ((UIView *)self.cardViews[i]).center;
            UIAttachmentBehavior *attachment = self.attachments[i];
            CGPoint distanceToDeduct;
            
            distanceToDeduct.x = attachment.anchorPoint.x - center.x;
            distanceToDeduct.y = attachment.anchorPoint.y - center.y;
            
            attachment.length -= hypot(distanceToDeduct.x, distanceToDeduct.y)/8.0;

        }
    }
    
}

- (void)attachCardViewsToPoint:(CGPoint)anchorPoint
{
    for (int i = 0; i< [self.cardViews count]; i++) {
        [self.attachments addObject:[[UIAttachmentBehavior alloc] initWithItem:self.cardViews[i]
                                                              attachedToAnchor:anchorPoint]];
        [self.animator addBehavior:self.attachments[i]];
    }
    
    
}

-(void)hlip:(UITapGestureRecognizer *)gesture
{
    if ([self.attachments count]) {
        [self removeAttachments];
        [self updateUI];

    }
    else {
        UIView *view = gesture.view;
        NSInteger choosenCardIndex = [self.cardViews indexOfObject:view];
        [self.game chooseCardAtIndex:choosenCardIndex];
        [self updateUI];
    }

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
        myFrame.origin = CGPointMake(0, 300);
        cardView.frame = myFrame;
        self.cardViews[i] =cardView;
        [self.placeForDeck addSubview:cardView];
        [self animateAddingCard:cardView];
        
        
    }
    //[self animateAddingCardViews:self.cardViews];
    [self removeAttachments];
    
    [self updateUI];
    
}


- (void) updateUI
{
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", self.game.score];


}

#pragma mark - Utilities

- (void)removeAttachments
{
    if (self.attachments) {
        
        for (UIAttachmentBehavior *attachment in self.attachments)
            [self.animator removeBehavior:attachment];
        
        self.attachments = nil;
    }
}

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

#pragma mark - Animations

-(void) animateReShuffle:(NSArray *)cardVievs
{
    [UIView animateWithDuration:0.7 animations:^{
        for (int i = 0; i < [self.cardViews count]; i++) {
            UIView *cardView = self.cardViews[i];
            
            CGRect myFrame = cardView.frame;
            myFrame.origin = [self originForCard:i];
            cardView.frame = myFrame;
            cardView.bounds = [self boundSizeForCard];
            [self.cardViews[i] setFrame:cardView.frame];
            [self.cardViews[i] setBounds:cardView.bounds];
        }
        
    } completion:^(BOOL finished) {
        
    }];
}

-(void)animateRemovingCards:(UIView *)cardView
{
    [UIView animateWithDuration:2.0 animations:^{
        
        //int x = (arc4random()%(int)(self.placeForDeck.bounds.size.width * 5))
        //- (int)self.placeForDeck.bounds.size.width*2;
        //int y = self.placeForDeck.bounds.size.height;
        cardView.center = CGPointMake(self.placeForDeck.bounds.size.height, self.placeForDeck.bounds.size.width);
        
    } completion:^(BOOL finished) {
        [cardView removeFromSuperview];
    }];
}
-(void)animateAddingCard:(UIView *)cardView
{
    [UIView transitionWithView:cardView duration:0.7 options:UIViewAnimationOptionTransitionFlipFromBottom animations:^{
        CGRect myFrame = cardView.frame;
        int choosenCardIndex = (int)[self.cardViews indexOfObject:cardView];
        myFrame.origin = [self originForCard:choosenCardIndex];
        cardView.frame = myFrame;
        cardView.bounds = [self boundSizeForCard];
        self.cardViews[choosenCardIndex] = cardView;
    }completion:nil];
}




-(void) animateAddingCardViews:(NSArray *)cardVievs
{
    [UIView animateWithDuration:0.7 animations:^{
        for (int i = 0; i < [self.cardViews count]; i++) {
            UIView *cardView = self.cardViews[i];
            
            CGRect myFrame = cardView.frame;
            myFrame.origin = [self originForCard:i];
            cardView.frame = myFrame;
            cardView.bounds = [self boundSizeForCard];
            self.cardViews[i] = cardView;
        }
        
    } completion:^(BOOL finished) {
        
    }];
}






@end
