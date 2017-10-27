//
//  TLVocabularyViewController.h
//  600EST
//
//  Created by NguyenThanhLuan on 15/02/2017.
//  Copyright © 2017 Olala. All rights reserved.
//

#import "TLLessonViewBaseController.h"

@import GoogleMobileAds;

@interface TLVocabularyViewController : TLLessonViewBaseController <GADInterstitialDelegate>{
    
    GADInterstitial *_interstitial;
    
    BOOL        _adsloaded;
    BOOL       _startLearning;
}

@property (weak, nonatomic) IBOutlet UITextView *vocabView;


- (void)setVocabFile:(NSString*)file;

@end
