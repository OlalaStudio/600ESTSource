//
//  TLQuestionCollectionViewCell.m
//  600EST
//
//  Created by Olala on 10/9/17.
//  Copyright © 2017 Olala. All rights reserved.
//

#import "TLQuestionCollectionViewCell.h"
#import "TLButton.h"
#import "commonDefines.h"

@implementation TLQuestionCollectionViewCell{
    
}

@dynamic delegate;

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)awakeFromNib{
    [super awakeFromNib];
    
    [self.anwserA setButtonCategory:TButton_A];
    [self.anwserB setButtonCategory:TButton_B];
    [self.anwserC setButtonCategory:TButton_C];
    [self.anwserD setButtonCategory:TButton_D];
    
    [self deSelectAll];
    
    [self.anwserA addTarget:self action:@selector(select_A:) forControlEvents:UIControlEventTouchUpInside];
    [self.anwserB addTarget:self action:@selector(select_B:) forControlEvents:UIControlEventTouchUpInside];
    [self.anwserC addTarget:self action:@selector(select_C:) forControlEvents:UIControlEventTouchUpInside];
    [self.anwserD addTarget:self action:@selector(select_D:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.lbanwserA addTarget:self action:@selector(select_A:) forControlEvents:UIControlEventTouchUpInside];
    [self.lbanwserB addTarget:self action:@selector(select_B:) forControlEvents:UIControlEventTouchUpInside];
    [self.lbanwserC addTarget:self action:@selector(select_C:) forControlEvents:UIControlEventTouchUpInside];
    [self.lbanwserD addTarget:self action:@selector(select_D:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.lbanwserA setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
    [self.lbanwserB setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
    [self.lbanwserC setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
    [self.lbanwserD setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
    
    [self.correcticon setHidden:YES];
    [self.incorrecticon setHidden:YES];
    
    [_lbTitle setText:_title];
}

-(void)setTitle:(NSString *)title{
    [super setTitle:title];
    
    [_lbTitle setText:title];
}

-(void)setupQuestionData:(NSDictionary *)data{
    questionData = data;
    
    NSString *question = [data objectForKey:@"question"];
    NSString *a = [data objectForKey:@"A"];
    NSString *b = [data objectForKey:@"B"];
    NSString *c = [data objectForKey:@"C"];
    NSString *d = [data objectForKey:@"D"];
    
    [self.lbQuestion setText:[NSString stringWithFormat:@"%ld. %@",(long)_index.row + 1,question]];
    [self.lbanwserA setTitle:[NSString stringWithFormat:@"%@",a] forState:UIControlStateNormal];
    [self.lbanwserB setTitle:[NSString stringWithFormat:@"%@",b] forState:UIControlStateNormal];
    [self.lbanwserC setTitle:[NSString stringWithFormat:@"%@",c] forState:UIControlStateNormal];
    [self.lbanwserD setTitle:[NSString stringWithFormat:@"%@",d] forState:UIControlStateNormal];
}

#pragma mark - Target / Actions
- (void)select_A:(id)sender {
    NSLog(@"[Photo]select A");
    
    _anwser = kAnwserA;
    
    [self deSelectAll];
    
    [_anwserA setButtonState:TButton_State_Select];
    [_lbanwserA setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
}

- (void)select_B:(id)sender {
    NSLog(@"[Photo]select B");
    
    _anwser = kAnwserB;
    
    [self deSelectAll];
    
    [_anwserB setButtonState:TButton_State_Select];
    [_lbanwserB setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
}

- (void)select_C:(id)sender {
    NSLog(@"[Photo]select C");
    
    _anwser = kAnwserC;
    
    [self deSelectAll];
    
    [_anwserC setButtonState:TButton_State_Select];
    [_lbanwserC setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
}

- (void)select_D:(id)sender {
    NSLog(@"[Photo]select D");
    
    _anwser = kAnwserD;
    
    [self deSelectAll];
    
    [_anwserD setButtonState:TButton_State_Select];
    [_lbanwserD setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
}

-(void)deSelectAll{
    
    [_anwserA setButtonState:TButton_State_Unselect];
    [_anwserB setButtonState:TButton_State_Unselect];
    [_anwserC setButtonState:TButton_State_Unselect];
    [_anwserD setButtonState:TButton_State_Unselect];
    
    [_lbanwserA setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_lbanwserB setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_lbanwserC setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_lbanwserD setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    if (_delegate) {
        [_delegate didSelectAnwser:_anwser forCell:self];
    }
}

-(void)updateSelection:(AnwserState)state{
    _anwser = state;
    
    [_anwserA setButtonState:TButton_State_Unselect];
    [_anwserB setButtonState:TButton_State_Unselect];
    [_anwserC setButtonState:TButton_State_Unselect];
    [_anwserD setButtonState:TButton_State_Unselect];
    
    [_lbanwserA setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_lbanwserB setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_lbanwserC setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_lbanwserD setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    if (_anwser == kAnwserA) {
        [_anwserA setButtonState:TButton_State_Select];
        [_lbanwserA setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    }
    else if (_anwser == kAnwserB){
        [_anwserB setButtonState:TButton_State_Select];
        [_lbanwserB setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    }
    else if (_anwser == kAnwserC){
        [_anwserC setButtonState:TButton_State_Select];
        [_lbanwserC setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    }
    else if (_anwser == kAnwserD){
        [_anwserD setButtonState:TButton_State_Select];
        [_lbanwserD setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    }
}

-(void)hideCheckAnwser{
    [_correcticon setHidden:YES];
    [_incorrecticon setHidden:YES];
}

-(NSInteger)showAnwser{
    
    CGRect rect = CGRectZero;
    
    [_correcticon setHidden:YES];
    [_incorrecticon setHidden:YES];
    
    switch (_anwser) {
        case kAnwserA:
            rect = [_anwserA frame];
            break;
        case kAnwserB:
            rect = [_anwserB frame];
            break;
        case kAnwserC:
            rect = [_anwserC frame];
            break;
        case kAnwserD:
            rect = [_anwserD frame];
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
    NSString *validAnwser = [questionData objectForKey:@"answer"];
    CGRect rect = CGRectZero;
    
    if ([[validAnwser uppercaseString] isEqualToString:@"A"]) {
        rect = [_anwserA frame];
    }
    else if ([[validAnwser uppercaseString] isEqualToString:@"B"]){
        rect = [_anwserB frame];
    }
    else if ([[validAnwser uppercaseString] isEqualToString:@"C"]){
        rect = [_anwserC frame];
    }
    else if ([[validAnwser uppercaseString] isEqualToString:@"D"]){
        rect = [_anwserD frame];
    }
    
    [_correcticon setHidden:NO];
    [_correcticon setFrame:rect];
}

-(BOOL)checkAnwser{
    
    NSString *validAnwser = [questionData objectForKey:@"answer"];
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
