//
//  TLTableViewCell.h
//  ESLListening
//
//  Created by NguyenThanhLuan on 19/12/2016.
//  Copyright © 2016 Olala. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TLLessonDelegate <NSObject>

-(void)didClickStartLesson:(NSInteger)tag;

@end

typedef enum LessonState: NSUInteger {
    kNone,
    kPass,
    kFail,
} LessonState;

@interface TLTableViewCell : UITableViewCell{
    LessonState     _state;
}

@property id<TLLessonDelegate>  lessonDelegate;
@property (assign,nonatomic) LessonState  state;

@property (weak, nonatomic) IBOutlet UIImageView    *avata;
@property (weak, nonatomic) IBOutlet UILabel        *title;

@property (weak, nonatomic) IBOutlet UIImageView *readingBackground;
@property (weak, nonatomic) IBOutlet UIImageView *readingPercen;


@property (weak, nonatomic) IBOutlet UIImageView    *listeningBackground;
@property (weak, nonatomic) IBOutlet UIImageView    *listeningPercen;

@property (weak, nonatomic) IBOutlet UILabel        *lbListeningPercen;
@property (weak, nonatomic) IBOutlet UILabel        *lbReadingPercen;

@property (weak, nonatomic) IBOutlet UIButton       *btStart;

-(void)setDisplayTitle:(NSString*)title;
-(void)setDisplayAvata:(NSString*)image;
-(void)updateUI;

- (IBAction)startLesson_Action:(id)sender;

@end
