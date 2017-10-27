//
//  TLCollectionViewCellBase.m
//  600EST
//
//  Created by Olala on 10/6/17.
//  Copyright © 2017 Olala. All rights reserved.
//

#import "TLCollectionViewCellBase.h"

@implementation TLCollectionViewCellBase
@synthesize anwser = _anwser;
@synthesize qNumber = _qNumber;
@synthesize index = _index;
@synthesize delegate = _delegate;

-(void)awakeFromNib{
    [super awakeFromNib];
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

-(void)setTitle:(NSString *)title{
    _title = title;
}

-(void)updateSelection:(AnwserState)state{
    _anwser = state;
}

-(BOOL)checkAnwser{
    return NO;
}

-(void)hideCheckAnwser{
    
}

@end
