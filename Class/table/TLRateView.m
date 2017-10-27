//
//  TLRateView.m
//  600EST
//
//  Created by Olala on 10/3/17.
//  Copyright © 2017 Olala. All rights reserved.
//

#import "TLRateView.h"

@implementation TLRateView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)setrate:(NSInteger)value{
    rate = value;
    
    [self reset];
    
    for (TLRateImageView *item in [self subviews]) {
        if ([item isKindOfClass:[TLRateImageView class]]) {
            if ([item tag] <= value) {
                [item setState:YES];
            }
        }
    }
}

-(void)reset{
    
    for (TLRateImageView *item in [self subviews]) {
        if ([item isKindOfClass:[TLRateImageView class]]) {
            [item setState:NO];
        }
    }
}

-(void)setmaxrate:(NSInteger)value{
    maxrate = value;
}

@end
