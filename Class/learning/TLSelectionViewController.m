//
//  TLSelectionViewController.m
//  600EST
//
//  Created by Olala on 10/2/17.
//  Copyright © 2017 Olala. All rights reserved.
//

#import "TLSelectionViewController.h"

@interface TLSelectionViewController (){
    NSString *lessonName;
    BOOL            _adsloaded;
    NSInteger        displayCount;
    GADInterstitial *_interstitial;
}

@end

@implementation TLSelectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    lessonName = [ldata objectForKey:@"name"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [self.navigationItem setTitle:lessonName];
    
    if (!_adsloaded) {
        //show ads
        _interstitial = [self createAndLoadInterstitial];
    }
}

-(void)viewDidAppear:(BOOL)animated{
    
    NSDictionary *lessonDic = [[NSUserDefaults standardUserDefaults] objectForKey:lessonName];
    NSNumber *listening = [lessonDic objectForKey:@"listening"];
    NSNumber *incomplete = [lessonDic objectForKey:@"incomplete"];
    NSNumber *reading = [lessonDic objectForKey:@"reading"];
    
    [_ratelistening setrate:[listening integerValue]];
    [_ratecompletion setrate:[incomplete integerValue]];
    [_ratereading setrate:[reading integerValue]];
    
    displayCount++;
    
    if (displayCount % 5 == 0 && _adsloaded == YES) {
        [_interstitial presentFromRootViewController:self];
        _adsloaded = NO;
    }
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

-(void)setData:(NSDictionary *)data{
    ldata = data;
}

- (IBAction)vocabulary_Action:(id)sender {
    
    TLVocabularyViewController *vocaview = [self.storyboard instantiateViewControllerWithIdentifier:@"idvocabularyview"];
    [vocaview setVocabFile:[ldata objectForKey:@"vocabulary"]];
    [vocaview setLessonName:lessonName];
    
    [self.navigationController pushViewController:vocaview animated:YES];
}

- (IBAction)listening_Action:(id)sender {
    
    TLListeningViewController *listeningview = [self.storyboard instantiateViewControllerWithIdentifier:@"idlisteningview"];
    [listeningview setListeningDictionary:[ldata objectForKey:@"listening"]];
    [listeningview setLessonName:lessonName];
    
    [self.navigationController pushViewController:listeningview animated:YES];
}

- (IBAction)textcomplete_Action:(id)sender {
    
    TLIncompleteViewController *incompleteview = [self.storyboard instantiateViewControllerWithIdentifier:@"idtextcompleteview"];
    [incompleteview setIncompleteArray:[ldata objectForKey:@"incomplete"]];
    [incompleteview setLessonName:lessonName];
    
    [self.navigationController pushViewController:incompleteview animated:YES];
}

- (IBAction)reading_Action:(id)sender {
    
    TLReadingViewController *readingview = [self.storyboard instantiateViewControllerWithIdentifier:@"idreadingview"];
    [readingview setReadingDictionary:[ldata objectForKey:@"reading"]];
    [readingview setLessonName:lessonName];
    
    [self.navigationController pushViewController:readingview animated:YES];
}
@end
