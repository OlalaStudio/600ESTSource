//
//  PlayerBarView.h
//  StreamingAudio
//
//  Created by NguyenThanhLuan on 19/12/2016.
//  Copyright © 2016 Olala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "PlayerBarButton.h"
#import "Reachability.h"

typedef enum : NSUInteger {
    kCategory_None,
    kCategory_Local,
    kCategory_Internet,
} CategoryFile;

@protocol PlayerBarViewDelegate <NSObject>

-(void)didClickPlayer:(CategoryFile)filetype;
-(void)didClickReplayPlayer:(CategoryFile)filetype;
-(void)didFinishPlayer:(CategoryFile)filetype;
-(void)didReadyPlayer:(CategoryFile)filetype ready:(BOOL)ready;
-(void)didUpdateCurrentTime:(NSTimeInterval)ctime;

@end

@interface PlayerBarView : UIView <PlayerButtonDelegate,AVAudioPlayerDelegate>{
    
    id timeObserver;
}

@property id<PlayerBarViewDelegate>         playerBarDelegate;

@property(nonatomic, retain) AVAudioPlayer  *audioPlayer;
@property(nonatomic, retain) AVPlayer       *internetPlayer;
@property(nonatomic, retain) AVPlayerItem   *internetPlayerItem;
@property(nonatomic, assign) CategoryFile   category;

@property NSString     *playerURL;

@property IBOutlet     PlayerBarButton      *playbutton;
@property IBOutlet     UILabel              *txtCurrentTime;
@property IBOutlet     UISlider             *timeSlider;

-(void)loadContent;
-(void)start;
-(void)stop;

@end
