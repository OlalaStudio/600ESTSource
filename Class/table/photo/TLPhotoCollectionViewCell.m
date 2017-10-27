//
//  TLPhotoCollectionViewCell.m
//  600EST
//
//  Created by Olala on 10/6/17.
//  Copyright © 2017 Olala. All rights reserved.
//

#import "TLPhotoCollectionViewCell.h"

@implementation TLPhotoCollectionViewCell{
    
}
@dynamic delegate;
@synthesize lbTitle = _lbTitle;

-(void)awakeFromNib{
    [super awakeFromNib];
    
    [self.btA setButtonCategory:TButton_A];
    [self.btB setButtonCategory:TButton_B];
    [self.btC setButtonCategory:TButton_C];
    [self.btD setButtonCategory:TButton_D];
    
    [self deSelectAll];
    
    [self.btA addTarget:self action:@selector(select_A:) forControlEvents:UIControlEventTouchUpInside];
    [self.btB addTarget:self action:@selector(select_B:) forControlEvents:UIControlEventTouchUpInside];
    [self.btC addTarget:self action:@selector(select_C:) forControlEvents:UIControlEventTouchUpInside];
    [self.btD addTarget:self action:@selector(select_D:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.correcticon setHidden:YES];
    [self.incorrecticon setHidden:YES];
    
    [_lbTitle setText:_title];
}

-(void)setPhotoData:(NSDictionary *)data{
    _photoData = data;
    
    [_photo setImage:[UIImage imageNamed:[_photoData objectForKey:@"image"]]];
}

-(void)setTitle:(NSString *)title{
    [super setTitle:title];
    
    [_lbTitle setText:title];
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

- (void)select_D:(id)sender {
    NSLog(@"[Photo]select D");
    
    _anwser = kAnwserD;
    
    [self deSelectAll];
    
    [_btD setButtonState:TButton_State_Select];
}

-(void)deSelectAll{
    
    [_btA setButtonState:TButton_State_Unselect];
    [_btB setButtonState:TButton_State_Unselect];
    [_btC setButtonState:TButton_State_Unselect];
    [_btD setButtonState:TButton_State_Unselect];
    
    if (_delegate) {
        [_delegate didSelectAnwser:_anwser forCell:self];
    }
}

-(void)updateSelection:(AnwserState)state{
    _anwser = state;
    
    [_btA setButtonState:TButton_State_Unselect];
    [_btB setButtonState:TButton_State_Unselect];
    [_btC setButtonState:TButton_State_Unselect];
    [_btD setButtonState:TButton_State_Unselect];
    
    if (_anwser == kAnwserA) {
        [_btA setButtonState:TButton_State_Select];
    }
    else if (_anwser == kAnwserB){
        [_btB setButtonState:TButton_State_Select];
    }
    else if (_anwser == kAnwserC){
        [_btC setButtonState:TButton_State_Select];
    }
    else if (_anwser == kAnwserD){
        [_btD setButtonState:TButton_State_Select];
    }
}

-(void)hideCheckAnwser{
    [self.correcticon setHidden:YES];
    [self.incorrecticon setHidden:YES];
}

-(NSInteger)showAnwser{
    
    CGRect rect = CGRectZero;
    
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
        case kAnwserD:
            rect = [_btD frame];
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
    NSString *validAnwser = [_photoData objectForKey:@"answer"];
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
    else if ([[validAnwser uppercaseString] isEqualToString:@"D"]){
        rect = [_btD frame];
    }
    
    [_correcticon setHidden:NO];
    [_correcticon setFrame:rect];
}

-(BOOL)checkAnwser{
    
    NSString *validAnwser = [_photoData objectForKey:@"answer"];
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
