//
//  TLQuestionTableViewCell.h
//  
//
//  Created by NguyenThanhLuan on 21/02/2017.
//
//

#import "TLTableViewCellBase.h"

@class TLButton;

@interface TLQuestionTableViewCell : TLTableViewCellBase{
    NSDictionary     *_data;
}

@property (nonatomic)  NSDictionary  *data;

@property (weak, nonatomic) IBOutlet UILabel *question;

@property (weak, nonatomic) IBOutlet TLButton *anwserA;
@property (weak, nonatomic) IBOutlet TLButton *anwserB;
@property (weak, nonatomic) IBOutlet TLButton *anwserC;
@property (weak, nonatomic) IBOutlet TLButton *anwserD;

- (IBAction)select_A:(id)sender;
- (IBAction)select_B:(id)sender;
- (IBAction)select_C:(id)sender;
- (IBAction)select_D:(id)sender;


@end
