//
//  TLIncompleteViewController.h
//  600EST
//
//  Created by NguyenThanhLuan on 15/02/2017.
//  Copyright © 2017 Olala. All rights reserved.
//

#import "TLLessonViewBaseController.h"
#import "TLTableViewCellBase.h"

@interface TLIncompleteViewController : TLLessonViewBaseController <UITableViewDelegate,UITableViewDataSource,TLTableViewCellDelegate>{
    NSMutableDictionary     *uDic;
}

@property (weak, nonatomic) IBOutlet UITableView *tableview;

- (IBAction)showAnwser_Action:(id)sender;

@end
