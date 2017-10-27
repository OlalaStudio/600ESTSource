//
//  TLSelectionViewController.h
//  600EST
//
//  Created by Olala on 10/2/17.
//  Copyright © 2017 Olala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLVocabularyViewController.h"
#import "TLListeningViewController.h"
#import "TLIncompleteViewController.h"
#import "TLReadingViewController.h"
#import "TLRateView.h"

@import GoogleMobileAds;

@interface TLSelectionViewController : UIViewController <GADInterstitialDelegate>{
    NSDictionary *ldata;
}

@property (weak, nonatomic) IBOutlet UIButton *btvocabulary;
@property (weak, nonatomic) IBOutlet UIButton *btlistening;
@property (weak, nonatomic) IBOutlet UIButton *bttextcomplete;
@property (weak, nonatomic) IBOutlet UIButton *btreading;

@property (weak, nonatomic) IBOutlet TLRateView *ratelistening;
@property (weak, nonatomic) IBOutlet TLRateView *ratecompletion;
@property (weak, nonatomic) IBOutlet TLRateView *ratereading;

-(void)setData:(NSDictionary*)data;

- (IBAction)vocabulary_Action:(id)sender;
- (IBAction)listening_Action:(id)sender;
- (IBAction)textcomplete_Action:(id)sender;
- (IBAction)reading_Action:(id)sender;


@end
