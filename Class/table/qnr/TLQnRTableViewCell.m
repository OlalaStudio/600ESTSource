//
//  TLQnRTableViewCell.m
//  
//
//  Created by NguyenThanhLuan on 21/02/2017.
//
//

#import "TLQnRTableViewCell.h"
#import "TLButton.h"

@implementation TLQnRTableViewCell
@synthesize data = _data;
@dynamic anwser;
@dynamic qNumber;
@dynamic index;
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
    
    _anwser = kUnknow;
    
    [self deSelectAll];
    
    [self.anwserA addTarget:self action:@selector(select_A:) forControlEvents:UIControlEventTouchUpInside];
    [self.anwserB addTarget:self action:@selector(select_B:) forControlEvents:UIControlEventTouchUpInside];
    [self.anwserC addTarget:self action:@selector(select_C:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)setData:(NSString *)data{
    _data = data;
}

-(BOOL)checkAnwser{
    NSString *validAnwser = _data;
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

#pragma mark - Target / Actions
- (void)select_A:(id)sender {
    NSLog(@"[QnR]select A");
    
    _anwser = kAnwserA;
    
    [self deSelectAll];
    
    [_anwserA.titleLabel setFont:[UIFont boldSystemFontOfSize:FONT_SIZE]];
    [_anwserA setTitleColor:SELECT_COLOR forState:UIControlStateNormal];
}

- (void)select_B:(id)sender {
    NSLog(@"[QnR]select B");
    
    _anwser = kAnwserB;
    
    [self deSelectAll];
    
    [_anwserB.titleLabel setFont:[UIFont boldSystemFontOfSize:FONT_SIZE]];
    [_anwserB setTitleColor:SELECT_COLOR forState:UIControlStateNormal];
}

- (void)select_C:(id)sender {
    NSLog(@"[QnR]select C");
    
    _anwser = kAnwserC;
    
    [self deSelectAll];
    
    [_anwserC.titleLabel setFont:[UIFont boldSystemFontOfSize:FONT_SIZE]];
    [_anwserC setTitleColor:SELECT_COLOR forState:UIControlStateNormal];
}


-(void)deSelectAll{
    
    [_anwserA.titleLabel setFont:[UIFont systemFontOfSize:FONT_SIZE]];
    [_anwserB.titleLabel setFont:[UIFont systemFontOfSize:FONT_SIZE]];
    [_anwserC.titleLabel setFont:[UIFont systemFontOfSize:FONT_SIZE]];
    
    [_anwserA setTitleColor:DESELECT_COLOR forState:UIControlStateNormal];
    [_anwserB setTitleColor:DESELECT_COLOR forState:UIControlStateNormal];
    [_anwserC setTitleColor:DESELECT_COLOR forState:UIControlStateNormal];
    
    if (_delegate) {
        [_delegate didSelectAnwser:_anwser forCell:self];
    }
}

-(void)updateSelection:(AnwserState)state{
    _anwser = state;
    
    [self.anwserA.titleLabel setFont:[UIFont systemFontOfSize:FONT_SIZE]];
    [self.anwserB.titleLabel setFont:[UIFont systemFontOfSize:FONT_SIZE]];
    [self.anwserC.titleLabel setFont:[UIFont systemFontOfSize:FONT_SIZE]];
    
    [self.anwserA setTitleColor:DESELECT_COLOR forState:UIControlStateNormal];
    [self.anwserB setTitleColor:DESELECT_COLOR forState:UIControlStateNormal];
    [self.anwserC setTitleColor:DESELECT_COLOR forState:UIControlStateNormal];
    
    if (_anwser == kAnwserA) {
        [self.anwserA.titleLabel setFont:[UIFont boldSystemFontOfSize:FONT_SIZE]];
        [self.anwserA setTitleColor:SELECT_COLOR forState:UIControlStateNormal];
    }
    else if (_anwser == kAnwserB){
        [self.anwserB.titleLabel setFont:[UIFont boldSystemFontOfSize:FONT_SIZE]];
        [self.anwserB setTitleColor:SELECT_COLOR forState:UIControlStateNormal];
    }
    else if (_anwser == kAnwserC){
        [self.anwserC.titleLabel setFont:[UIFont boldSystemFontOfSize:FONT_SIZE]];
        [self.anwserC setTitleColor:SELECT_COLOR forState:UIControlStateNormal];
    }
}

-(void)setQNumber:(NSInteger)qNumber{
    [super setQNumber:qNumber];
    
    [_number setText:[NSString stringWithFormat:@"%ld",(long)qNumber]];
}

@end
