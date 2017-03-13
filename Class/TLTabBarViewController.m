//
//  TLTabBarViewController.m
//  600EST
//
//  Created by NguyenThanhLuan on 15/02/2017.
//  Copyright © 2017 Olala. All rights reserved.
//

#import "TLTabBarViewController.h"

@interface TLTabBarViewController ()

@end

@implementation TLTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupLesson];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)setLessonData:(NSDictionary *)data{
    _lessonData = data;
}

-(void)setupLesson{
    NSLog(@"========================================");
    NSLog(@"============ Start Lesson ==============");
    
    NSArray *viewControlers = [self viewControllers];
    
    for (TLLessonViewBaseController *viewController in viewControlers) {
        
        if([viewController isKindOfClass:[TLVocabularyViewController class]]){
            NSLog(@"Vocabulary");
            
            NSString *vFile = [_lessonData objectForKey:@"vocabulary"];
            [viewController setVocabFile:vFile];
        }
        else if ([viewController isKindOfClass:[TLListeningViewController class]]){
            NSLog(@"Listening");
            
            NSDictionary *lDic = [_lessonData objectForKey:@"listening"];
            [viewController setListeningDictionary:lDic];
        }
        else if ([viewController isKindOfClass:[TLIncompleteViewController class]]){
            NSLog(@"Incomplete sentense");
            
            NSArray *iArray = [_lessonData objectForKey:@"incomplete"];
            [viewController setIncompleteArray:iArray];
        }
        else if ([viewController isKindOfClass:[TLReadingViewController class]]){
            NSLog(@"Reading Comprehension");
            
            NSDictionary *rDic = [_lessonData objectForKey:@"reading"];
            [viewController setReadingDictionary:rDic];
        }
        
        [viewController reloadView];
    }
}

@end
