//
//  TLListeningViewController.h
//  600EST
//
//  Created by NguyenThanhLuan on 16/02/2017.
//  Copyright © 2017 Olala. All rights reserved.
//

#import "TLLessonViewBaseController.h"
#import "TLTableViewCellBase.h"
#import "PlayerBarView.h"

@interface TLListeningViewController : TLLessonViewBaseController<UITableViewDelegate,UITableViewDataSource,TLTableViewCellDelegate,PlayerBarViewDelegate>
{
    NSString        *_audio;
    NSArray         *_conversation;
    NSDictionary    *_photo;
    NSArray         *_questionNresponse;
    NSArray         *_talk;
    
    NSMutableDictionary *uDic;
}

@property (weak, nonatomic) IBOutlet PlayerBarView  *playerBar;
@property (weak, nonatomic) IBOutlet UITableView    *tableview;

- (IBAction)showAnwser_Action:(id)sender;

@end
