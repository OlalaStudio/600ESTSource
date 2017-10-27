//
//  TLMainViewController.m
//  600EST
//
//  Created by NguyenThanhLuan on 16/02/2017.
//  Copyright © 2017 Olala. All rights reserved.
//

#import "TLMainViewController.h"
#import "commonDefines.h"

@import GoogleMobileAds;

@interface TLMainViewController (){
    BOOL            _adsloaded;
    NSInteger        displayCount;
    GADInterstitial *_interstitial;
}

@end

@implementation TLMainViewController{
    NSArray *metaArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //load banner ads
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        _adBannerView = [[GADBannerView alloc] initWithAdSize:kGADAdSizeFullBanner];
    }
    else{
        _adBannerView = [[GADBannerView alloc] initWithAdSize:kGADAdSizeBanner];
    }
    
    [_adBannerView setAdUnitID:@"ca-app-pub-4039533744360639/9647323308"];
    [_adBannerView setDelegate:self];
    [_adBannerView setRootViewController:self];
    
    [_tableView setDelegate:self];
    [_tableView setDataSource:self];
    [_tableView setAllowsMultipleSelection:NO];
    [_tableView setBackgroundColor:[UIColor whiteColor]];
    
    [_tableView registerNib:[UINib nibWithNibName:@"TLTableViewCell" bundle:nil] forCellReuseIdentifier:@"idCellNormal"];
    
    NSString *metadataPath = [[NSBundle mainBundle] pathForResource:@"metadata" ofType:@"plist"];
    
    metaArr = [[NSArray alloc] initWithContentsOfFile:metadataPath];
    
    //User data
    _userData = [[NSMutableDictionary alloc] initWithDictionary:[self userData]];
    
    [self.navigationController.navigationBar setBarTintColor:COLOR_BASE];
    [self.navigationController.navigationBar setTintColor:COLOR_TEXT];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
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
    
    [self writeUserData];
    
    GADRequest *request = [GADRequest request];
//    request.testDevices = @[kGADSimulatorID,@"aea500effe80e30d5b9edfd352b1602d"];
    
    [_adBannerView loadRequest:request];
    
    [self runRateApp];
    [_tableView reloadData];
    
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

-(void)writeUserData{
    NSString *strPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    strPath = [strPath stringByAppendingPathComponent:@"600ESTUserData.plist"];
    
    if([_userData writeToFile:strPath atomically:YES]){
        NSLog(@"Save user data success");
    }
    else{
        NSLog(@"Save user data fail");
    }
}

-(NSMutableDictionary*)userData{
    NSString *strPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    strPath = [strPath stringByAppendingPathComponent:@"600ESTUserData.plist"];
    
    NSMutableDictionary *userDic = [[NSMutableDictionary alloc] initWithContentsOfFile:strPath];
    
    if (!userDic) {
        userDic = [[NSMutableDictionary alloc] initWithCapacity:0];
    }
    
    return userDic;
}

#pragma mark - GADS Delegate
-(void)adViewDidReceiveAd:(GADBannerView *)bannerView
{
    NSLog(@"Banner load successfull");
    
    CGAffineTransform transform = CGAffineTransformMakeTranslation(0, bannerView.bounds.size.height*2);
    bannerView.transform = transform;
    
    [UIView animateWithDuration:0.5 animations:^{
        bannerView.transform = CGAffineTransformIdentity;
    }];
}

#pragma mark - TLLessonDelegate
-(void)didClickStartLesson:(NSInteger)tag{
    
    NSDictionary *lData = [metaArr objectAtIndex:tag];
    
    TLSelectionViewController *selectionview = (TLSelectionViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"idselectionview"];
    [selectionview setData:lData];
    [selectionview setModalTransitionStyle:UIModalTransitionStyleCoverVertical];

    [self.navigationController pushViewController:selectionview animated:YES];
    
    NSLog(@"Start lesson %ld", (long)tag);
}

-(void)adView:(GADBannerView *)bannerView didFailToReceiveAdWithError:(GADRequestError *)error
{
    NSLog(@"load banner fail");
    NSLog(@"%@",error);
}

#pragma mark - UITableView Delegate
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [[UIView alloc] initWithFrame:CGRectZero];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return _adBannerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return _adBannerView.frame.size.height;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [metaArr count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *item  = [metaArr objectAtIndex:indexPath.row];
    NSString *title     = [item objectForKey:@"name"];
    NSString *avate     = [item objectForKey:@"avata"];
    
    NSDictionary *registerField = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInteger:0], @"vocabulary"
                                   ,[NSNumber numberWithInteger:0], @"listening"
                                   ,[NSNumber numberWithInteger:0], @"incomplete"
                                   ,[NSNumber numberWithInteger:0], @"reading", nil];
    
    [[NSUserDefaults standardUserDefaults] registerDefaults:[NSDictionary dictionaryWithObject:registerField forKey:title]];
    
    TLTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"idCellNormal"];
    
    [cell setDisplayTitle:title];
    [cell setDisplayAvata:avate];
    [cell setTag:indexPath.row];
    [cell setLessonDelegate:self];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [(TLTableViewCell*)cell updateUI];
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
    NSDictionary *lData = [metaArr objectAtIndex:indexPath.row];
    
    NSLog(@"%@",lData);
    
    TLTabBarViewController *lessonViewController = (TLTabBarViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"idlessonview"];
    [lessonViewController setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [lessonViewController setLessonData:lData];
    [self presentViewController:lessonViewController animated:YES completion:nil];
     */
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 270;
}

#pragma mark - Setting
-(void)runRateApp
{
    //1190545147
    [Appirater setAppId:@"1214277884"];    // Change for your "Your APP ID"
    [Appirater setDaysUntilPrompt:1];     // Days from first entered the app until prompt
    [Appirater setUsesUntilPrompt:12];     // Number of uses until prompt
    [Appirater setTimeBeforeReminding:2]; // Days until reminding if the user taps "remind me"
    //[Appirater setDebug:YES];           // If you set this to YES it will display all the time
    
    //... Perhaps do stuff
    
    [Appirater appLaunched:YES];
}

@end
