//
//  TLMainViewController.m
//  600EST
//
//  Created by NguyenThanhLuan on 16/02/2017.
//  Copyright © 2017 Olala. All rights reserved.
//

#import "TLMainViewController.h"

@interface TLMainViewController ()

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
    [_tableView setSeparatorColor:[UIColor redColor]];
    
    [_tableView registerNib:[UINib nibWithNibName:@"TLTableViewCell" bundle:nil] forCellReuseIdentifier:@"idCellNormal"];
    
    NSString *metadataPath = [[NSBundle mainBundle] pathForResource:@"metadata" ofType:@"plist"];
    
    metaArr = [[NSArray alloc] initWithContentsOfFile:metadataPath];
    
    //User data
    _userData = [[NSMutableDictionary alloc] initWithDictionary:[self userData]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated{
    
    [self writeUserData];
    
    GADRequest *request = [GADRequest request];
//    request.testDevices = @[kGADSimulatorID,@"aea500effe80e30d5b9edfd352b1602d"];
    
    [_adBannerView loadRequest:request];
    
    [self runRateApp];
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
    TLTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"idCellNormal"];
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    cell.textLabel.textColor = [UIColor grayColor];
    
    NSDictionary *item  = [metaArr objectAtIndex:indexPath.row];
    NSString *title     = [item objectForKey:@"name"];
    NSString *avate     = [item objectForKey:@"avata"];
    
    [cell setDisplayTitle:title];
    [cell setDisplayAvata:avate];
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *lData = [metaArr objectAtIndex:indexPath.row];
    
    NSLog(@"%@",lData);
    
    TLTabBarViewController *lessonViewController = (TLTabBarViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"idlessonview"];
    [lessonViewController setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [lessonViewController setLessonData:lData];
    [self presentViewController:lessonViewController animated:YES completion:nil];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
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
