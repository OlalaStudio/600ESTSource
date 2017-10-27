//
//  TLQnRView.h
//  600EST
//
//  Created by Olala on 10/6/17.
//  Copyright © 2017 Olala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "commonDefines.h"

@class TLButton;

@protocol TLQnRViewDelegate <NSObject>

-(void)didSelectAnwser:(AnwserState)state sender:(id)sender;

@end

@interface TLQnRView : UIView{
    id<TLQnRViewDelegate> _delegate;
    
    NSString *qnrdata;
}

@property id<TLQnRViewDelegate> delegate;

@property (nonatomic, assign) IBOutlet TLButton* btA;
@property (nonatomic, assign) IBOutlet TLButton* btB;
@property (nonatomic, assign) IBOutlet TLButton* btC;

@property (nonatomic, assign) IBOutlet UIImageView *correcticon;
@property (nonatomic, assign) IBOutlet UIImageView *incorrecticon;

-(void)setQnRData:(NSString*)data;
-(void)updateSelection:(AnwserState)state;
-(void)resetUI;
-(NSInteger)showAnwser;
-(BOOL)checkAnwser;

@end
