//
//  TLMainViewController.h
//  600EST
//
//  Created by NguyenThanhLuan on 16/02/2017.
//  Copyright © 2017 Olala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Appirater.h"
#import "TLTabBarViewController.h"
#import "TLTableViewCell.h"

@import GoogleMobileAds;

@interface TLMainViewController : UIViewController <UITableViewDelegate,UITableViewDataSource,GADBannerViewDelegate,AppiraterDelegate>
{
    NSMutableDictionary     *_userData;
    GADBannerView           *_adBannerView;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
