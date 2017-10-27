//
//  TLTableViewCellBase.h
//  
//
//  Created by NguyenThanhLuan on 21/02/2017.
//
//

#import <UIKit/UIKit.h>
#import "commonDefines.h"

#define FONT_SIZE       18
#define SELECT_COLOR    [UIColor greenColor]
#define DESELECT_COLOR  [UIColor blackColor]

@class TLTableViewCellBase;

@protocol TLTableViewCellDelegate <NSObject>

- (void)didSelectAnwser:(AnwserState)anwser forCell:(TLTableViewCellBase*)cell;

@end

@interface TLTableViewCellBase : UITableViewCell{
    AnwserState     _anwser;
    NSInteger       _qNumber;
    NSIndexPath     *_index;
    
    id<TLTableViewCellDelegate> _delegate;
}

@property id<TLTableViewCellDelegate>  delegate;

@property AnwserState   anwser;
@property NSInteger     qNumber;
@property NSIndexPath   *index;

-(void)updateSelection:(AnwserState)state;
-(BOOL)checkAnwser;

@end
