//
//  TLLessonViewBaseController.m
//  600EST
//
//  Created by NguyenThanhLuan on 15/02/2017.
//  Copyright © 2017 Olala. All rights reserved.
//

#import "TLLessonViewBaseController.h"

@interface TLLessonViewBaseController ()

@end

@implementation TLLessonViewBaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

-(void)setVocabFile:(NSString *)file{
    _vocabFile = file;
}

-(void)setListeningDictionary:(NSDictionary *)dic{
    _listeningDic = dic;
}

-(void)setIncompleteArray:(NSArray *)arr{
    _incompleteArr = arr;
}

-(void)setReadingDictionary:(NSDictionary *)dic{
    _readingDic = dic;
}

-(void)reloadView{
    
}

-(void)showAnwser{
    NSString *messageAnswer = [NSString stringWithFormat:@"%lu/%lu",(unsigned long)rAnwser,(unsigned long)tAnwser];
    
    UIAlertView *scoreAlert = [[UIAlertView alloc] initWithTitle:@"Your Score"
                                                         message:messageAnswer
                                                        delegate:nil
                                               cancelButtonTitle:@"OK"
                                               otherButtonTitles: nil];
    [scoreAlert show];
}
@end
