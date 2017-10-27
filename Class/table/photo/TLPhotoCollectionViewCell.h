//
//  TLPhotoCollectionViewCell.h
//  600EST
//
//  Created by Olala on 10/6/17.
//  Copyright © 2017 Olala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLCollectionViewCellBase.h"
#import "commonDefines.h"
#import "TLButton.h"

@interface TLPhotoCollectionViewCell : TLCollectionViewCellBase{
    NSDictionary *_photoData;
}

@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet UIImageView *photo;

@property (weak, nonatomic) IBOutlet UIImageView *correcticon;
@property (weak, nonatomic) IBOutlet UIImageView *incorrecticon;

@property (weak, nonatomic) IBOutlet TLButton *btA;
@property (weak, nonatomic) IBOutlet TLButton *btB;
@property (weak, nonatomic) IBOutlet TLButton *btC;
@property (weak, nonatomic) IBOutlet TLButton *btD;

-(void)setPhotoData:(NSDictionary*)data;


@end
