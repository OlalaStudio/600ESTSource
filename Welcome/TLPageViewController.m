//
//  TLPageViewController.m
//  PageView
//
//  Created by NguyenThanhLuan on 12/12/2016.
//  Copyright © 2016 Olala. All rights reserved.
//

#import "TLPageViewController.h"

@interface TLPageViewController()

@end

@implementation TLPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [_btnStart setHidden:YES];
    [_pageDescription setHidden:NO];
    
    switch (self.index) {
        case 0:
            [_partIndex setText:@"Part I"];
            [_pageDescription setText:@"You will look at ten photographs. For each photograph you will hear four statements. You will have to choose which statement has the best description of the picture."];
            break;
        case 1:
            [_partIndex setText:@"Part II"];
            [_pageDescription setText:@"You will be tested on your ability to respond to a question. It is very important that you can understand and identify wh-questions. You will listen to three possible responses. Only one of the responses is correct."];
            break;
        case 2:
            [_partIndex setText:@"Part III"];
            [_pageDescription setText:@"You will listen to a short conversation between a man and a woman. After the conversation, you will answer three questions about the dialogue.There will be four possible answers for each question. Typical questions include, who, what, where, when, why, and how."];
            break;
        case 3:
            [_partIndex setText:@"Part IV"];
            [_pageDescription setText:@"You will listen to a short talk. It might be an announcement, a radio advertisement, or a telephone recording. You will listen to the talk and read a few questions about it."];
            break;
        case 4:
            [_partIndex setText:@"Part V"];
           [_pageDescription setText:@"You will read a sentence that has one blank spot. There will be four choices of words or phrases to choose from. You will have to choose the one that you think completes the sentence. When the sentence is complete it must be grammatically correct."];
            break;
        case 5:
            [_partIndex setText:@"Part VI"];
            [_pageDescription setText:@"You will read four passages of text, such as an article, a letter, a form, and an e-mail. In each reading passage there will be three blanks to fill in"];
            break;
        case 6:
            [_partIndex setText:@"Part VII"];
            [_pageDescription setText:@"You will read passages in the form of letters, ads, memos, faxes, schedules, etc. The reading section has a number of single passages and 4 double passages. You will be asked 2-4 questions about each single passage, and 5 questions for each double passage."];
            [_btnStart setHidden:NO];
            break;
        default:
            break;
    }
}

-(void)viewDidAppear:(BOOL)animated
{
    
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

- (IBAction)getStart:(id)sender {
    if (_delegate != nil && [_delegate respondsToSelector:@selector(GetStart)]) {
        [_delegate GetStart];
    }
}
@end
