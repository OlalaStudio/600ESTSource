//
//  PlayerBarButton.m
//  StreamingAudio
//
//  Created by NguyenThanhLuan on 19/12/2016.
//  Copyright © 2016 Olala. All rights reserved.
//

#import "PlayerBarButton.h"

@implementation PlayerBarButton
@synthesize playState = _playState;

-(void)awakeFromNib{
    [super awakeFromNib];
    
    _playState = kUnknowState;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [super drawRect:rect];
    
    if (_playState == kUnknowState || _playState == kPlayState) {
        [self.imageView setImage:[UIImage imageNamed:@"play"]];
    }
    else{
        [self.imageView setImage:[UIImage imageNamed:@"pause"]];
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    if (_playState == kUnknowState || _playState == kPlayState) {
        _playState = kPauseState;
        
        if (_playDelegate) {
            [_playDelegate play];
        }
    }
    else{
        _playState = kPlayState;
        
        if (_playDelegate) {
            [_playDelegate pause];
        }
    }
    
    [self setNeedsDisplay];
}

@end
