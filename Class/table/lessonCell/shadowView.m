//
//  shadowView.m
//  600EST
//
//  Created by Olala on 9/29/17.
//  Copyright © 2017 Olala. All rights reserved.
//

#import "shadowView.h"

@implementation shadowView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)layoutSubviews{
    self.backgroundColor = [UIColor clearColor];
    CALayer *viewlayer = [self layer];
    
    [viewlayer setShadowColor:[[UIColor lightGrayColor] CGColor]];
    [viewlayer setShadowOpacity:1.0];
    [viewlayer setShadowRadius:12];
    [viewlayer setShadowOffset:CGSizeMake( 0 , 1 )];
    [viewlayer setShadowPath:[UIBezierPath bezierPathWithRect:viewlayer.bounds].CGPath];
}

@end
