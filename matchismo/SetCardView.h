//
//  SetGameView.h
//  matchismo
//
//  Created by Равил Файрушин on 19.08.15.
//  Copyright (c) 2015 Равил Файрушин. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SetCard.h"

@interface SetCardView : UIView

@property(nonatomic) NSUInteger color;
@property(nonatomic) NSUInteger symbol;
@property(nonatomic) NSUInteger shading;
@property(nonatomic) NSUInteger number;
@property (nonatomic,strong) UITapGestureRecognizer *tap;
@property (nonatomic,strong) UIPanGestureRecognizer *pan;
@property(nonatomic) BOOL choosen;
@property(nonatomic) BOOL showStar;

-(void)setCardFeatures:(SetCard *)card;

@end
