//
//  TLMainViewController.h
//  600EST
//
//  Created by NguyenThanhLuan on 16/02/2017.
//  Copyright © 2017 Olala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Appirater.h"
#import "TLSelectionViewController.h"
#import "TLTableViewCell.h"

@import GoogleMobileAds;

@interface TLMainViewController : UIViewController <UITableViewDelegate,UITableViewDataSource,GADInterstitialDelegate,TLLessonDelegate,GADBannerViewDelegate,AppiraterDelegate>
{
    NSMutableDictionary     *_userData;
    GADBannerView           *_adBannerView;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
