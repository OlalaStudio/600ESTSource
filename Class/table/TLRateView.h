//
//  TLRateView.h
//  600EST
//
//  Created by Olala on 10/3/17.
//  Copyright © 2017 Olala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLRateImageView.h"

@interface TLRateView : UIView{
    NSInteger rate;
    NSInteger maxrate;
}

-(void)setmaxrate:(NSInteger)value;
-(void)setrate:(NSInteger)value;

@end
