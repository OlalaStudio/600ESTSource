//
//  TLVocabularyViewController.m
//  600EST
//
//  Created by NguyenThanhLuan on 15/02/2017.
//  Copyright © 2017 Olala. All rights reserved.
//

#import "TLVocabularyViewController.h"

@interface TLVocabularyViewController ()

@end

@implementation TLVocabularyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self reloadView];
    
     _startLearning = NO;
    
    //show ads
    _interstitial = [self createAndLoadInterstitial];
}

-(void)viewWillAppear:(BOOL)animated{
    _adsloaded = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark -
#pragma mark Setup View
-(void)setVocabFile:(NSString *)file{
    _vocabFile = file;
}

-(void)reloadView{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:_vocabFile ofType:@"rtf"];
    
    _vocabView.attributedText =[[NSAttributedString alloc] initWithFileURL:[NSURL fileURLWithPath:filePath]
                                                                    options:nil
                                                         documentAttributes:nil
                                                                      error:nil];

}

-(void)viewWillDisappear:(BOOL)animated{
    
}

#pragma mark -
#pragma mark UI Action
- (IBAction)closeLesson_Action:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(GADInterstitial*)createAndLoadInterstitial
{
    _interstitial = [[GADInterstitial alloc] initWithAdUnitID:@"ca-app-pub-4039533744360639/2124056506"];
    
    GADRequest *request = [GADRequest request];
//        request.testDevices = @[kGADSimulatorID,@"aea500effe80e30d5b9edfd352b1602d"];
    
    [_interstitial setDelegate:self];
    [_interstitial loadRequest:request];
    
    _adsloaded = NO;
    
    return _interstitial;
}

#pragma mark - Ads Delegate
-(void)interstitialDidReceiveAd:(GADInterstitial *)ad
{
    if (!_startLearning) {
        [ad presentFromRootViewController:self];
        _adsloaded = YES;
    }
    else{
        _interstitial = ad;
        _adsloaded = NO;
    }
}

-(void)interstitialDidFailToPresentScreen:(GADInterstitial *)ad
{
    _adsloaded = NO;
    NSLog(@"Fail to load interstitial ads");
}
@end
