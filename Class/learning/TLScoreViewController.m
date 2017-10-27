//
//  TLScoreViewController.m
//  600EST
//
//  Created by Olala on 10/19/17.
//  Copyright © 2017 Olala. All rights reserved.
//

#import "TLScoreViewController.h"

@import GoogleMobileAds;

@interface TLScoreViewController (){
    BOOL            _adsloaded;
    NSInteger        displayCount;
    GADInterstitial *_interstitial;
}

@end

@implementation TLScoreViewController
@synthesize delegate = _delegate;
@synthesize scoreView;
@synthesize scorechart;
@synthesize totalScore;
@synthesize yourScore;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view

    CALayer *scorelayer = [self.scoreView layer];
    [scorelayer setMasksToBounds:YES];
    [scorelayer setCornerRadius:15];
    [scorelayer setShadowColor:(__bridge CGColorRef _Nullable)([UIColor grayColor])];
    [scorelayer setShadowOpacity:0.8];
    [scorelayer setShadowOffset:CGSizeMake(0.0, 0.0)];
    
    yscore = 0;
    tscore = 0;
    
    self.view.gestureRecognizers = @[[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTaponScoreView:)]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setupChart{
    [scorechart setupWithCount:1 TotalValue:tscore];
    [scorechart setChartDataSource:self];
    [scorechart setChartDelegate:self];
    [scorechart reloadDialWithAnimation:YES];
}

-(void)setScore:(NSInteger)yourscore total:(NSInteger)totalscore{
    
    yscore = yourscore;
    tscore = totalscore;
    
    [self.yourScore setText:[NSString stringWithFormat:@"The score you got!"]];
    [self.totalScore setText:[NSString stringWithFormat:@"Total score : %ld",totalscore]];
    
    [self setupChart];
}

-(void)didTaponScoreView:(UITapGestureRecognizer*)tap{
    if (_delegate && [_delegate respondsToSelector:@selector(didTaponScoreView)]) {
        [_delegate didTaponScoreView];
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Chart Delegate
- (void) touchNuDialChart:(NUDialChart*) chart{
    
}

- (BOOL) dialChart:(NUDialChart*) dialChart defaultCircleAtIndex:(int) _index{
    return NO;
}

#pragma NUDialChart Datasource
- (NSNumber*) dialChart:(NUDialChart*) dialChart valueOfCircleAtIndex:(int) _index
{
    return [NSNumber numberWithDouble:yscore];
}

- (UIColor* ) dialChart:(NUDialChart*) dialChart colorOfCircleAtIndex:(int) _index{
    return [UIColor orangeColor];
}

- (NSString* ) dialChart:(NUDialChart*) dialChart textOfCircleAtIndex:(int) _index{
    return nil;
}

- (UIColor* ) dialChart:(NUDialChart*) dialChart textColorOfCircleAtIndex:(int) _index{
    return [UIColor whiteColor];
}

- (BOOL) isShowCenterLabelInDial:(NUDialChart*) dialChart
{
    return NO;
}

- (int) nuscoreInDialChart:(NUDialChart*) dialChart
{
    return yscore;
}

- (UIColor*) centerTextColorInDialChart:(NUDialChart*) dialChart{
    return [UIColor whiteColor];
}

- (UIColor*) centerBackgroundColorInDialChart:(NUDialChart*) dialChart{
    return [UIColor whiteColor];
}
@end
