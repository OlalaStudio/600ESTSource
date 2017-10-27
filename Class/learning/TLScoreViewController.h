//
//  TLScoreViewController.h
//  600EST
//
//  Created by Olala on 10/19/17.
//  Copyright © 2017 Olala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <NuweScoreCharts/NuweScoreCharts.h>

@protocol TLScoreViewProtocol <NSObject>

-(void)didTaponScoreView;

@end

@interface TLScoreViewController : UIViewController <NUDialChartDelegate,NUDialChartDataSource>{
    
    int yscore;
    int tscore;
    
    id<TLScoreViewProtocol> _delegate;
}

@property id<TLScoreViewProtocol>   delegate;
@property (weak, nonatomic) IBOutlet UIView *scoreView;
@property (weak, nonatomic) IBOutlet UILabel *totalScore;
@property (weak, nonatomic) IBOutlet UILabel *yourScore;
@property (weak, nonatomic) IBOutlet NUDialChart *scorechart;

-(void)setScore:(NSInteger)yourscore total:(NSInteger)totalscore;
@end
