//
//  TLLessonViewBaseController.m
//  600EST
//
//  Created by NguyenThanhLuan on 15/02/2017.
//  Copyright © 2017 Olala. All rights reserved.
//

#import "TLLessonViewBaseController.h"


@interface TLLessonViewBaseController (){
    BOOL            _adsloaded;
    NSInteger        displayCount;
    GADInterstitial *_interstitial;
}

@end

@implementation TLLessonViewBaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if (!_adsloaded) {
        //show ads
        _interstitial = [self createAndLoadInterstitial];
    }
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(GADInterstitial*)createAndLoadInterstitial
{
    _interstitial = [[GADInterstitial alloc] initWithAdUnitID:@"ca-app-pub-4039533744360639/2124056506"];
    
    GADRequest *request = [GADRequest request];
//    request.testDevices = @[kGADSimulatorID,@"aea500effe80e30d5b9edfd352b1602d"];
    
    [_interstitial setDelegate:self];
    [_interstitial loadRequest:request];
    
    _adsloaded = NO;
    
    return _interstitial;
}

#pragma mark - Ads Delegate
-(void)interstitialDidReceiveAd:(GADInterstitial *)ad
{
    _interstitial = ad;
    _adsloaded = YES;
}

-(void)interstitialDidFailToPresentScreen:(GADInterstitial *)ad
{
    _adsloaded = NO;
    NSLog(@"Fail to load interstitial ads");
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)setVocabFile:(NSString *)file{
    _vocabFile = file;
}

-(void)setListeningDictionary:(NSDictionary *)dic{
    _listeningDic = dic;
}

-(void)setIncompleteArray:(NSArray *)arr{
    _incompleteArr = arr;
}

-(void)setReadingDictionary:(NSDictionary *)dic{
    _readingDic = dic;
}

-(void)setLessonName:(NSString *)name{
    lessonName = name;
}

-(void)reloadView{
    
}

-(void)showAnwser{
    
    scoreview = (TLScoreViewController*)[self.storyboard instantiateViewControllerWithIdentifier:@"idscoreview"];
    [scoreview setDelegate:self];
    scoreview.view.frame = self.view.frame;
    [scoreview setScore:rAnwser total:tAnwser];
    
    [self addChildViewController:scoreview];
    [self.view addSubview:[scoreview view]];
    
    scoreview.view.transform = CGAffineTransformMakeScale(0.8, 0.8);
    scoreview.view.alpha = 0.0;
    
    for (UIBarButtonItem *item in self.navigationItem.rightBarButtonItems) {
        [item setEnabled:NO];
    }
    
    for (UIBarButtonItem *item in self.navigationItem.leftBarButtonItems) {
        [item setEnabled:NO];
    }
    
    [self.navigationItem.backBarButtonItem setEnabled:NO];
    
    [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self->scoreview.view.alpha = 1;
        self->scoreview.view.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:^(BOOL finished) {
        
    }];
    
    displayCount++;
}

#pragma mark - Score Delegate
-(void)didTaponScoreView{
    
    NSLog(@"did tap on score view");
    
    [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self->scoreview.view.alpha = 0;
        self->scoreview.view.transform = CGAffineTransformMakeScale(1.5, 1.5);
    } completion:^(BOOL finished) {
        for (UIBarButtonItem *item in self.navigationItem.rightBarButtonItems) {
            [item setEnabled:YES];
        }
        
        for (UIBarButtonItem *item in self.navigationItem.leftBarButtonItems) {
            [item setEnabled:YES];
        }
        
        [self.navigationItem.backBarButtonItem setEnabled:YES];
        
        [self->scoreview.view removeFromSuperview];
        [self->scoreview removeFromParentViewController];
        
        if (displayCount % 3 == 0 && _adsloaded == YES) {
            [_interstitial presentFromRootViewController:self];
            _adsloaded = NO;
        }
    }];
}
@end
