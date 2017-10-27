//
//  PlayerBarView.m
//  StreamingAudio
//
//  Created by NguyenThanhLuan on 19/12/2016.
//  Copyright © 2016 Olala. All rights reserved.
//

#import "PlayerBarView.h"

@implementation PlayerBarView{
    NSTimer *localTimer;
}
@synthesize playerURL = _playerURL;

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    [super drawRect:rect];
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:4.0];
    
    UIColor *color = [UIColor colorWithRed:0.61 green:0.67 blue:0.45 alpha:0.6];
    [color setFill];
    [path fill];
}

-(void)awakeFromNib{
    [super awakeFromNib];
    
    [_playbutton setPlayDelegate:self];
    [_txtCurrentTime setText:@"00:00"];
}

-(void)stop
{
    if (_category == kCategory_Internet) {
        if (_internetPlayer) {
            
            [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
            [_internetPlayer removeObserver:self forKeyPath:@"status"];
            
            [_internetPlayer pause];
            _internetPlayer = nil;
        }
    }
    else{
        [_audioPlayer stop];
    }
    
    [localTimer invalidate];
}

-(void)dealloc
{
    if (_internetPlayer) {
        
        [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
        [_internetPlayer removeObserver:self forKeyPath:@"status"];
        
        [_internetPlayer pause];
        _internetPlayer = nil;
    }
}

-(void)loadContent{
    
    if (_category == kCategory_Internet) {
        
        Reachability *network = [Reachability reachabilityWithHostName:@"https://github.com"];
        if ([network currentReachabilityStatus] != NotReachable) {
            [_playbutton setEnabled:YES];
        }
        else{
            [self showNetworkError];
            [_playbutton setEnabled:NO];
        }
    }
    else{
        NSURL *soundFileURL = [NSURL fileURLWithPath:_playerURL];
        
        _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFileURL error:NULL];
        [_audioPlayer setDelegate:self];
        [_audioPlayer setVolume:1.0];
    }
}

-(void)showNetworkError
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Network error"
                                                    message:@"Check your internet connection and try again!"
                                                   delegate:self
                                          cancelButtonTitle:@"Close"
                                          otherButtonTitles:nil];
    [alert show];
}

-(void)didReachtoEnd{
    
    if (_category == kCategory_Internet) {

        [_internetPlayer seekToTime:CMTimeMakeWithSeconds(0, NSEC_PER_SEC)];
    }
    else{
        
    }
    
    [_playbutton setPlayState:kPlayState];
    [_playbutton setNeedsDisplay];
    
    [self resetProgressBar];
    
    //callback for check score
    if (_playerBarDelegate) {
        [_playerBarDelegate didFinishPlayer:_category];
    }
}

#pragma mark - Update Progress

-(void)initProgressBar{
    
    double duration;
    
    if (_category == kCategory_Internet) {
        duration = CMTimeGetSeconds(_internetPlayer.currentItem.asset.duration);
    }
    else{
        duration = [_audioPlayer duration];
    }
    
    [_timeSlider setMaximumValue:duration];
    [_timeSlider setMinimumValue:0];
    [_timeSlider setValue:[_audioPlayer currentTime]];
}

-(void)resetProgressBar{
    if (_category == kCategory_Internet) {
        
    }
    else{
        
    }
    
    [_timeSlider setValue:0];
}

-(void)updateAudioProgress{
    if (_category == kCategory_Internet) {
        double currentTime = CMTimeGetSeconds(_internetPlayer.currentItem.currentTime);
        
        [_timeSlider setValue:currentTime];
        
        NSUInteger durationSeconds = currentTime;
        NSUInteger minutes = floor(durationSeconds % 3600 / 60);
        NSUInteger seconds = floor(durationSeconds % 3600 % 60);
        NSString *time = [NSString stringWithFormat:@"%02ld:%02ld", (unsigned long)minutes, seconds];
        
        [_txtCurrentTime setText:time];
        
        //callback for update progress
        if (_playerBarDelegate) {
            [_playerBarDelegate didUpdateCurrentTime:currentTime];
        }
    }
    else{
        [_timeSlider setValue:[_audioPlayer currentTime]];
        
        NSUInteger durationSeconds = [_audioPlayer currentTime];
        NSUInteger minutes = floor(durationSeconds % 3600 / 60);
        NSUInteger seconds = floor(durationSeconds % 3600 % 60);
        NSString *time = [NSString stringWithFormat:@"%02ld:%02ld", (unsigned long)minutes, seconds];
        
        [_txtCurrentTime setText:time];
        
        //callback for update progress
        if (_playerBarDelegate) {
            [_playerBarDelegate didUpdateCurrentTime:[_audioPlayer currentTime]];
        }
    }
}

#pragma mark - Player Notification
-(void)playeritemDidReachtoEnd:(NSNotification*)notification{
    NSLog(@"end of audio");
    
    [self didReachtoEnd];
}

#pragma mark - Play Button delegate
-(void)play{
    
    if (_category == kCategory_Internet) {
        
        if (!_internetPlayer) {
            AVPlayer *player = [[AVPlayer alloc]initWithURL:[NSURL URLWithString:_playerURL]];
            self.internetPlayer = player;
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(playerItemDidReachEnd:)
                                                         name:AVPlayerItemDidPlayToEndTimeNotification
                                                       object:[self.internetPlayer currentItem]];
            
            _internetPlayerItem = [self.internetPlayer currentItem];
            [self.internetPlayer addObserver:self forKeyPath:@"status" options:0 context:nil];
            localTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(updateAudioProgress) userInfo:nil repeats:YES];
            
            [self.internetPlayer play];
            
            //callback for show loading
            if (_playerBarDelegate && [_playerBarDelegate respondsToSelector:@selector(didClickPlayer:)]) {
                [_playerBarDelegate didClickPlayer:_category];
            }
        }
        else{
            [_internetPlayer play];
            
            //callback for show loading
            if (_playerBarDelegate && [_playerBarDelegate respondsToSelector:@selector(didClickReplayPlayer:)]) {
                [_playerBarDelegate didClickReplayPlayer:_category];
            }
        }
        
    }
    else{
        [self initProgressBar];
        
        [_audioPlayer prepareToPlay];
        [_audioPlayer play];
        
        localTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(updateAudioProgress) userInfo:nil repeats:YES];
        
        //callback for show loading
        if (_playerBarDelegate) {
            [_playerBarDelegate didClickPlayer:_category];
        }
    }
}

-(void)pause{
    if (_category == kCategory_Internet) {
        [_internetPlayer pause];
    }
    else{
        [_audioPlayer pause];
    }
}

#pragma mark - AVAudioPlayerDelegate - Local
-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    [self didReachtoEnd];
}

#pragma mark - AVAudioPlayerDelegate - Internet
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    if (object == self.internetPlayer && [keyPath isEqualToString:@"status"]) {
        
        [_playbutton setPlayState:kPlayState];
        
        BOOL readytoplay = NO;
        
        if (self.internetPlayer.status == AVPlayerStatusFailed) {
            NSLog(@"AVPlayer Failed");
            
        } else if (self.internetPlayer.status == AVPlayerStatusReadyToPlay) {
            NSLog(@"AVPlayerStatusReadyToPlay");
            
            [self initProgressBar];
            [_playbutton setPlayState:kPauseState];
            
            readytoplay = YES;
            
        } else if (self.internetPlayer.status == AVPlayerItemStatusUnknown) {
            NSLog(@"AVPlayer Unknown");
        }
        
        //callback for show result
        if (_playerBarDelegate) {
            [_playerBarDelegate didReadyPlayer:_category ready:readytoplay];
        }
    }
}

- (void)playerItemDidReachEnd:(NSNotification *)notification {
    
    //  code here to play next sound file
    [self didReachtoEnd];
}

@end
