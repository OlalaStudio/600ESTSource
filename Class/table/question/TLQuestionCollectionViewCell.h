//
//  TLQuestionCollectionViewCell.h
//  600EST
//
//  Created by Olala on 10/9/17.
//  Copyright © 2017 Olala. All rights reserved.
//

#import "TLCollectionViewCellBase.h"

@class TLButton;

@interface TLQuestionCollectionViewCell : TLCollectionViewCellBase{
    NSDictionary *questionData;
}


@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet UILabel *lbQuestion;

@property (weak, nonatomic) IBOutlet TLButton *anwserA;
@property (weak, nonatomic) IBOutlet TLButton *anwserB;
@property (weak, nonatomic) IBOutlet TLButton *anwserC;
@property (weak, nonatomic) IBOutlet TLButton *anwserD;

@property (weak, nonatomic) IBOutlet UIButton *lbanwserA;
@property (weak, nonatomic) IBOutlet UIButton *lbanwserB;
@property (weak, nonatomic) IBOutlet UIButton *lbanwserC;
@property (weak, nonatomic) IBOutlet UIButton *lbanwserD;

@property (weak, nonatomic) IBOutlet UIImageView    *correcticon;
@property (weak, nonatomic) IBOutlet UIImageView    *incorrecticon;


-(void)setupQuestionData:(NSDictionary*)data;


@end
