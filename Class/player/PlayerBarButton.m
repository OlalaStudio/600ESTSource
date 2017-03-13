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
    
    _playState = kunknow;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [super drawRect:rect];
    
    if (_playState == kunknow || _playState == kPlay) {
        [self.imageView setImage:[UIImage imageNamed:@"play.png"]];
    }
    else{
        [self.imageView setImage:[UIImage imageNamed:@"pause.png"]];
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    if (_playState == kunknow || _playState == kPlay) {
        _playState = kPause;
        
        if (_playDelegate) {
            [_playDelegate play];
        }
    }
    else{
        _playState = kPlay;
        
        if (_playDelegate) {
            [_playDelegate pause];
        }
    }
    
    [self setNeedsDisplay];
}

-(void)setPlayState:(State)playState{
    _playState = playState;
    
    [self setNeedsDisplay];
}

-(State)playState{
    return _playState;
}

@end
