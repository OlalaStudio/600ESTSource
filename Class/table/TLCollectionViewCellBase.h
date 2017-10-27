//
//  TLCollectionViewCellBase.h
//  600EST
//
//  Created by Olala on 10/6/17.
//  Copyright © 2017 Olala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "commonDefines.h"

@class TLCollectionViewCellBase;

@protocol TLCollectionViewCellDelegate <NSObject>

- (void)didSelectAnwser:(AnwserState)anwser forCell:(TLCollectionViewCellBase*)cell;

@end

@interface TLCollectionViewCellBase : UICollectionViewCell{
    AnwserState     _anwser;
    NSInteger       _qNumber;
    NSIndexPath     *_index;
    
    NSString        *_title;
    
    id<TLCollectionViewCellDelegate> _delegate;
}

@property id<TLCollectionViewCellDelegate>  delegate;

@property (nonatomic, assign) AnwserState   anwser;
@property (nonatomic, assign) NSInteger     qNumber;
@property (nonatomic, retain) NSIndexPath   *index;

-(void)setTitle:(NSString*)title;
-(void)updateSelection:(AnwserState)state;
-(void)hideCheckAnwser;
-(NSInteger)showAnwser;
-(BOOL)checkAnwser;

@end
