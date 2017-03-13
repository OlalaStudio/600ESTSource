//
//  ViewController.h
//  600EST
//
//  Created by NguyenThanhLuan on 15/02/2017.
//  Copyright (c) 2017 Olala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLPageViewController.h"
#import "TLMainViewController.h"

@interface ViewController : UIViewController <UIPageViewControllerDelegate,UIPageViewControllerDataSource,TLPageViewControllerDelegate>
{
     NSMutableArray          *_itemList;
}

@property (strong,nonatomic) UIPageViewController   *pageController;
@property (strong,nonatomic) UIPageControl          *pageControll;

@end

