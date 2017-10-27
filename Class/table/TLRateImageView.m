//
//  TLRateImage.m
//  600EST
//
//  Created by Olala on 10/3/17.
//  Copyright © 2017 Olala. All rights reserved.
//

#import "TLRateImageView.h"

@implementation TLRateImageView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)setState:(BOOL)state{
    if (state) {
        [self setImage:[UIImage imageNamed:@"star"]];
    }
    else{
        [self setImage:[UIImage imageNamed:@"starbackground"]];
    }
}

@end
