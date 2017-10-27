//
//  TLVocabularyViewController.m
//  600EST
//
//  Created by NguyenThanhLuan on 15/02/2017.
//  Copyright © 2017 Olala. All rights reserved.
//

#import "TLVocabularyViewController.h"

@interface TLVocabularyViewController ()

@end

@implementation TLVocabularyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self reloadView];
    
    [self.navigationItem setTitle:@"Vocabulary"];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
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

#pragma mark -
#pragma mark Setup View
-(void)setVocabFile:(NSString *)file{
    _vocabFile = file;
}

-(void)reloadView{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:_vocabFile ofType:@"rtf"];
    
    _vocabView.attributedText =[[NSAttributedString alloc] initWithFileURL:[NSURL fileURLWithPath:filePath]
                                                                    options:nil
                                                         documentAttributes:nil
                                                                      error:nil];

}

-(void)viewWillDisappear:(BOOL)animated{
    
}

-(void)viewDidLayoutSubviews{
    [self.vocabView setContentOffset:CGPointZero animated:YES];
    [self.vocabView setContentInset:UIEdgeInsetsZero];
    
    [self.vocabView setEditable:NO];
    [self.vocabView setSelectable:NO];
}
@end
