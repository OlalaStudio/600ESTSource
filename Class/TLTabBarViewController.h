//
//  TLTabBarViewController.h
//  600EST
//
//  Created by NguyenThanhLuan on 15/02/2017.
//  Copyright © 2017 Olala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLLessonViewBaseController.h"
#import "TLVocabularyViewController.h"
#import "TLReadingViewController.h"
#import "TLListeningViewController.h"
#import "TLIncompleteViewController.h"

@interface TLTabBarViewController : UITabBarController{
    NSDictionary    *_lessonData;
}

-(void)setLessonData:(NSDictionary*)data;

@end
