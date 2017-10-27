//
//  itemView.m
//  600EST
//
//  Created by Olala on 9/29/17.
//  Copyright © 2017 Olala. All rights reserved.
//

#import "roundedView.h"
#import <QuartzCore/QuartzCore.h>

@implementation roundedView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)layoutSubviews{
    self.backgroundColor = [UIColor whiteColor];
    CALayer *viewlayer = [self layer];
    
    [viewlayer setMasksToBounds:YES];
    [viewlayer setCornerRadius:15];
}

@end
