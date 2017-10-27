//
//  TLQnRCollectionViewCell.h
//  600EST
//
//  Created by Olala on 10/6/17.
//  Copyright © 2017 Olala. All rights reserved.
//

#import "TLCollectionViewCellBase.h"
#import "TLQnRView.h"

@interface TLQnRCollectionViewCell : TLCollectionViewCellBase <TLQnRViewDelegate>{
    NSArray *qnrData;
}

@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet TLQnRView *question1;
@property (weak, nonatomic) IBOutlet TLQnRView *question2;


-(void)setQnRdata:(NSArray*)data;

@end
