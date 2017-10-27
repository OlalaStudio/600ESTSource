//
//  TLQnRView.m
//  600EST
//
//  Created by Olala on 10/6/17.
//  Copyright © 2017 Olala. All rights reserved.
//

#import "TLQnRView.h"
#import "TLButton.h"

@implementation TLQnRView{
    AnwserState _anwser;
}
@synthesize delegate = _delegate;

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)awakeFromNib{
    [super awakeFromNib];
    
    [self.btA setButtonCategory:TButton_A];
    [self.btB setButtonCategory:TButton_B];
    [self.btC setButtonCategory:TButton_C];

    [self deSelectAll];
    
    [self.btA addTarget:self action:@selector(select_A:) forControlEvents:UIControlEventTouchUpInside];
    [self.btB addTarget:self action:@selector(select_B:) forControlEvents:UIControlEventTouchUpInside];
    [self.btC addTarget:self action:@selector(select_C:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.correcticon setHidden:YES];
    [self.incorrecticon setHidden:YES];
}


#pragma mark - Target / Actions
- (void)select_A:(id)sender {
    NSLog(@"[Photo]select A");
    
    _anwser = kAnwserA;
    
    [self deSelectAll];
    
    [_btA setButtonState:TButton_State_Select];
}

- (void)select_B:(id)sender {
    NSLog(@"[Photo]select B");
    
    _anwser = kAnwserB;
    
    [self deSelectAll];
    
    [_btB setButtonState:TButton_State_Select];
}

- (void)select_C:(id)sender {
    NSLog(@"[Photo]select C");
    
    _anwser = kAnwserC;
    
    [self deSelectAll];
    
    [_btC setButtonState:TButton_State_Select];
}

-(void)deSelectAll{
    
    [_btA setButtonState:TButton_State_Unselect];
    [_btB setButtonState:TButton_State_Unselect];
    [_btC setButtonState:TButton_State_Unselect];
    
    if (_delegate) {
        [_delegate didSelectAnwser:_anwser sender:self];
    }
}

-(void)updateSelection:(AnwserState)state{
    _anwser = state;
    
    [_btA setButtonState:TButton_State_Unselect];
    [_btB setButtonState:TButton_State_Unselect];
    [_btC setButtonState:TButton_State_Unselect];
    
    if (_anwser == kAnwserA) {
        [_btA setButtonState:TButton_State_Select];
    }
    else if (_anwser == kAnwserB){
        [_btB setButtonState:TButton_State_Select];
    }
    else if (_anwser == kAnwserC){
        [_btC setButtonState:TButton_State_Select];
    }
}

-(void)resetUI{
    [_correcticon setHidden:YES];
    [_incorrecticon setHidden:YES];
}

-(void)setQnRData:(NSString *)data{
    qnrdata = data;
}

-(NSInteger)showAnwser{
    CGRect rect = CGRectZero;
    
    [_correcticon setHidden:YES];
    [_incorrecticon setHidden:YES];
    
    switch (_anwser) {
        case kAnwserA:
            rect = [_btA frame];
            break;
        case kAnwserB:
            rect = [_btB frame];
            break;
        case kAnwserC:
            rect = [_btC frame];
            break;
        default:
            break;
    }
    
    if ([self checkAnwser]) {
        [_correcticon setHidden:NO];
        [_correcticon setFrame:rect];
        
        return 1;
    }
    else{
        if (_anwser != kUnknow) {
            [_incorrecticon setHidden:NO];
            [_incorrecticon setFrame:rect];
        }
        
        [self showCorrectAnwser];
    }
    
    return 0;
}

-(void)showCorrectAnwser{
    NSString *validAnwser = qnrdata;
    CGRect rect = CGRectZero;
    
    if ([[validAnwser uppercaseString] isEqualToString:@"A"]) {
        rect = [_btA frame];
    }
    else if ([[validAnwser uppercaseString] isEqualToString:@"B"]){
        rect = [_btB frame];
    }
    else if ([[validAnwser uppercaseString] isEqualToString:@"C"]){
        rect = [_btC frame];
    }
    
    [_correcticon setHidden:NO];
    [_correcticon setFrame:rect];
}

-(BOOL)checkAnwser{
    
    NSString *validAnwser = qnrdata;
    AnwserState validAnwserSt = kUnknow;
    
    if ([[validAnwser uppercaseString] isEqualToString:@"A"]) {
        validAnwserSt = kAnwserA;
    }
    else if ([[validAnwser uppercaseString] isEqualToString:@"B"]){
        validAnwserSt = kAnwserB;
    }
    else if ([[validAnwser uppercaseString] isEqualToString:@"C"]){
        validAnwserSt = kAnwserC;
    }
    else if ([[validAnwser uppercaseString] isEqualToString:@"D"]){
        validAnwserSt = kAnwserD;
    }
    
    if (_anwser != validAnwserSt) {
        return NO;
    }
    
    return YES;
}
@end
