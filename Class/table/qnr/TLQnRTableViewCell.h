//
//  TLQnRTableViewCell.h
//  
//
//  Created by NguyenThanhLuan on 21/02/2017.
//
//

#import "TLTableViewCellBase.h"

@class TLButton;

@interface TLQnRTableViewCell : TLTableViewCellBase{
    NSString     *_data;
}

@property (nonatomic) NSString*  data;

@property (weak, nonatomic) IBOutlet UILabel *number;

@property (weak, nonatomic) IBOutlet TLButton *anwserA;
@property (weak, nonatomic) IBOutlet TLButton *anwserB;
@property (weak, nonatomic) IBOutlet TLButton *anwserC;

@end
