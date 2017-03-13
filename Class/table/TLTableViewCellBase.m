//
//  TLTableViewCellBase.m
//  
//
//  Created by NguyenThanhLuan on 21/02/2017.
//
//

#import "TLTableViewCellBase.h"

@implementation TLTableViewCellBase
@synthesize anwser = _anwser;
@synthesize qNumber = _qNumber;
@synthesize index = _index;
@synthesize delegate = _delegate;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setQNumber:(NSInteger)qNumber{
    _qNumber = qNumber;
}

-(NSInteger)qNumber{
    return _qNumber;
}

-(void)setAnwser:(AnwserState)anwser{
    _anwser = anwser;
}

-(AnwserState)anwser{
    return _anwser;
}


-(void)setIndex:(NSIndexPath *)index{
    _index = index;
}

-(NSIndexPath*)index{
    return _index;
}

-(void)updateSelection:(AnwserState)state{
    _anwser = state;
}

-(BOOL)checkAnwser{
    return NO;
}
@end
