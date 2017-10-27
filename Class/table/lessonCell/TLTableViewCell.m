//
//  TLTableViewCell.m
//  ESLListening
//
//  Created by NguyenThanhLuan on 19/12/2016.
//  Copyright © 2016 Olala. All rights reserved.
//

#import "TLTableViewCell.h"

@implementation TLTableViewCell
@synthesize state = _state;
@synthesize avata = _avata;
@synthesize title = _title;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _state = kNone;
}

-(void)updateUI{
    [self updatePercenListening];
    [self updatePercenReading];
}

-(void)updatePercenListening{
    NSDictionary *dic = [[NSUserDefaults standardUserDefaults] objectForKey:[_title text]];
    NSNumber *listening = [dic valueForKey:@"listening"];
    
    double percen = [listening integerValue] * 100 /9;
    
    CGRect rect = [_listeningBackground frame];
    rect.size.width = rect.size.width * percen/100;
    
    [_listeningPercen setFrame:rect];
    [_lbListeningPercen setText:[NSString stringWithFormat:@"%ld%%",(long)percen]];
}

-(void)updatePercenReading{
    
    NSDictionary *dic = [[NSUserDefaults standardUserDefaults] objectForKey:[_title text]];
    NSNumber *reading = [dic valueForKey:@"reading"];
    NSNumber *incomplete = [dic valueForKey:@"incomplete"];
    
    double percen = ([reading integerValue] + [incomplete integerValue]) * 100 /11;

    CGRect rect = [_readingBackground frame];
    rect.size.width = rect.size.width * percen/100;
    
    [_readingPercen setFrame:rect];
    [_lbReadingPercen setText:[NSString stringWithFormat:@"%ld%%",(long)percen]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setState:(LessonState)state{
    _state = state;
}

-(LessonState)state{
    return _state;
}

- (void)setDisplayAvata:(NSString*)image
{
    [_avata setImage:[UIImage imageNamed:image]];
}

-(void)setDisplayTitle:(NSString *)title
{
    [_title setText:title];
}

- (IBAction)startLesson_Action:(id)sender {
    
    if (_lessonDelegate && [_lessonDelegate respondsToSelector:@selector(didClickStartLesson:)]) {
        [_lessonDelegate didClickStartLesson:[self tag]];
    }
}

@end
