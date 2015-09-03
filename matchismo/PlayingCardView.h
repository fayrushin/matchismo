//
//  PlayingCardView.h
//  matchismo
//
//  Created by Равил Файрушин on 20.08.15.
//  Copyright (c) 2015 Равил Файрушин. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayingCardView : UIView

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;
@property (nonatomic) BOOL faceUp;
//-(void)flip:(UITapGestureRecognizer *)gesture;
@property (strong, nonatomic) UITapGestureRecognizer *tap;
@property (nonatomic,strong) UIPanGestureRecognizer *pan;

@end
