//
//  TLQnRCollectionViewCell.m
//  600EST
//
//  Created by Olala on 10/6/17.
//  Copyright © 2017 Olala. All rights reserved.
//

#import "TLQnRCollectionViewCell.h"

@implementation TLQnRCollectionViewCell

@dynamic delegate;
@dynamic index;
@synthesize lbTitle = _lbTitle;
@synthesize question1 = _question1;
@synthesize question2 = _question2;

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)awakeFromNib{
    [super awakeFromNib];
    
    [_question1 setDelegate:self];
    [_question2 setDelegate:self];
    
    [_lbTitle setText:_title];
}

-(void)setTitle:(NSString *)title{
    [super setTitle:title];
    
    [_lbTitle setText:title];
}

-(void)setQnRdata:(NSArray *)data{
    qnrData = data;
    
    [_question1 setQnRData:[qnrData objectAtIndex:0]];
    [_question2 setQnRData:[qnrData objectAtIndex:1]];
}

#pragma mark - TLQnRView Delegate
-(void)didSelectAnwser:(AnwserState)state sender:(id)sender{
    
    if ([sender tag] == 0) {
        //question 0
        self.index = [NSIndexPath indexPathForRow:0 inSection:_index.section];
    }
    else if ([sender tag] == 1){
        // question 1
        self.index = [NSIndexPath indexPathForRow:1 inSection:_index.section];
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(didSelectAnwser:forCell:)]) {
        [_delegate didSelectAnwser:state forCell:self];
    }
}

-(void)updateSelection:(AnwserState)state{
    
    if ([self.index row] == 0) {
        [_question1 updateSelection:state];
    }
    else if ([self.index row] == 1){
        [_question2 updateSelection:state];
    }
}

-(void)hideCheckAnwser{
    [_question1 resetUI];
    [_question2 resetUI];
}

-(NSInteger)showAnwser{
    NSInteger count = 0;
    
    count += [_question1 showAnwser];
    count += [_question2 showAnwser];
    
    return count;
}

-(BOOL)checkAnwser{
     NSInteger count = 0;
    
    count += [_question1 checkAnwser];
    count += [_question2 checkAnwser];
    
    return count;
}

@end
