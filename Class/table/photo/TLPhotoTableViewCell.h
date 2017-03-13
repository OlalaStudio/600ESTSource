//
//  TLPhotoTableViewCell.h
//  
//
//  Created by NguyenThanhLuan on 21/02/2017.
//
//

#import "TLTableViewCellBase.h"

@class TLButton;

@interface TLPhotoTableViewCell : TLTableViewCellBase{
    NSDictionary    *_data;
    
    NSString        *_imagename;
}

@property (nonatomic) NSDictionary   *data;

@property (weak, nonatomic) IBOutlet UILabel *number;
@property (weak, nonatomic) IBOutlet UIImageView *photo;

@property (weak, nonatomic) IBOutlet TLButton *anwserA;
@property (weak, nonatomic) IBOutlet TLButton *anwserB;
@property (weak, nonatomic) IBOutlet TLButton *anwserC;
@property (weak, nonatomic) IBOutlet TLButton *anwserD;

@end
