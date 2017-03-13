//
//  TLReadingViewController.h
//  600EST
//
//  Created by NguyenThanhLuan on 16/02/2017.
//  Copyright © 2017 Olala. All rights reserved.
//

#import "TLLessonViewBaseController.h"
#import "TLTableViewCellBase.h"

@interface TLReadingViewController : TLLessonViewBaseController<UITableViewDelegate,UITableViewDataSource,TLTableViewCellDelegate>{
    NSMutableDictionary *uDic;
    
    NSString    *_letter;
    NSArray     *_question;
}

@property (weak, nonatomic) IBOutlet UITextView     *dialogView;
@property (weak, nonatomic) IBOutlet UITableView    *tableview;

- (IBAction)showAnwser_Action:(id)sender;
- (IBAction)showQuestion_Action:(id)sender;

@end
