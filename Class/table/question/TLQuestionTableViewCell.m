//
//  TLQuestionTableViewCell.m
//  
//
//  Created by NguyenThanhLuan on 21/02/2017.
//
//

#import "TLQuestionTableViewCell.h"
#import "TLButton.h"

@implementation TLQuestionTableViewCell
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
}

-(void)setData:(NSDictionary *)data{
    _data = data;
    
    NSString *question = [_data objectForKey:@"question"];
    NSString *a = [_data objectForKey:@"A"];
    NSString *b = [_data objectForKey:@"B"];
    NSString *c = [_data objectForKey:@"C"];
    NSString *d = [_data objectForKey:@"D"];
    
    [self.question setText:[NSString stringWithFormat:@"%ld. %@",(long)_qNumber,question]];
    [self.anwserA setTitle:[NSString stringWithFormat:@"A. %@",a] forState:UIControlStateNormal];
    [self.anwserB setTitle:[NSString stringWithFormat:@"B. %@",b] forState:UIControlStateNormal];
    [self.anwserC setTitle:[NSString stringWithFormat:@"C. %@",c] forState:UIControlStateNormal];
    [self.anwserD setTitle:[NSString stringWithFormat:@"D. %@",d] forState:UIControlStateNormal];
}

-(BOOL)checkAnwser{
    NSString *validAnwser = [_data objectForKey:@"answer"];
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
- (IBAction)select_A:(id)sender {
    NSLog(@"[Question]select A");
    
    _anwser = kAnwserA;
    
    [self deSelectAll];
    
    [self.anwserA.titleLabel setFont:[UIFont boldSystemFontOfSize:13]];
    [self.anwserA setTitleColor:SELECT_COLOR forState:UIControlStateNormal];
}

- (IBAction)select_B:(id)sender {
    NSLog(@"[Question]select B");
    
    _anwser = kAnwserB;
    
    [self deSelectAll];
    
    [self.anwserB.titleLabel setFont:[UIFont boldSystemFontOfSize:13]];
    [self.anwserB setTitleColor:SELECT_COLOR forState:UIControlStateNormal];
}

- (IBAction)select_C:(id)sender {
    NSLog(@"[Question]select C");
    
    _anwser = kAnwserC;
    
    [self deSelectAll];
    
    [self.anwserC.titleLabel setFont:[UIFont boldSystemFontOfSize:13]];
    [self.anwserC setTitleColor:SELECT_COLOR forState:UIControlStateNormal];
}

- (IBAction)select_D:(id)sender {
    NSLog(@"[Question]select D");
    
    _anwser = kAnwserD;
    
    [self deSelectAll];
    
    [self.anwserD.titleLabel setFont:[UIFont boldSystemFontOfSize:13]];
    [self.anwserD setTitleColor:SELECT_COLOR forState:UIControlStateNormal];
}

-(void)deSelectAll{

    [self.anwserA.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [self.anwserB.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [self.anwserC.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [self.anwserD.titleLabel setFont:[UIFont systemFontOfSize:13]];
    
    [self.anwserA setTitleColor:DESELECT_COLOR forState:UIControlStateNormal];
    [self.anwserB setTitleColor:DESELECT_COLOR forState:UIControlStateNormal];
    [self.anwserC setTitleColor:DESELECT_COLOR forState:UIControlStateNormal];
    [self.anwserD setTitleColor:DESELECT_COLOR forState:UIControlStateNormal];
    
    if (_delegate) {
        [_delegate didSelectAnwser:_anwser forCell:self];
    }
}

-(void)updateSelection:(AnwserState)state{
    _anwser = state;
    
    [self.anwserA.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [self.anwserB.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [self.anwserC.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [self.anwserD.titleLabel setFont:[UIFont systemFontOfSize:13]];
    
    [self.anwserA setTitleColor:DESELECT_COLOR forState:UIControlStateNormal];
    [self.anwserB setTitleColor:DESELECT_COLOR forState:UIControlStateNormal];
    [self.anwserC setTitleColor:DESELECT_COLOR forState:UIControlStateNormal];
    [self.anwserD setTitleColor:DESELECT_COLOR forState:UIControlStateNormal];
    
    if (_anwser == kAnwserA) {
        [self.anwserA.titleLabel setFont:[UIFont boldSystemFontOfSize:13]];
        [self.anwserA setTitleColor:SELECT_COLOR forState:UIControlStateNormal];
    }
    else if (_anwser == kAnwserB){
        [self.anwserB.titleLabel setFont:[UIFont boldSystemFontOfSize:13]];
        [self.anwserB setTitleColor:SELECT_COLOR forState:UIControlStateNormal];
    }
    else if (_anwser == kAnwserC){
        [self.anwserC.titleLabel setFont:[UIFont boldSystemFontOfSize:13]];
        [self.anwserC setTitleColor:SELECT_COLOR forState:UIControlStateNormal];
    }
    else if (_anwser == kAnwserD){
        [self.anwserD.titleLabel setFont:[UIFont boldSystemFontOfSize:13]];
        [self.anwserD setTitleColor:SELECT_COLOR forState:UIControlStateNormal];
    }
}

-(void)setQNumber:(NSInteger)qNumber{
    [super setQNumber:qNumber];
    
    _qNumber = qNumber;
}
@end
