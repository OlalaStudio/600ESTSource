//
//  TLReadingViewController.m
//  600EST
//
//  Created by NguyenThanhLuan on 16/02/2017.
//  Copyright © 2017 Olala. All rights reserved.
//

#import "TLReadingViewController.h"
#import "TLQuestionTableViewCell.h"

@interface TLReadingViewController ()

@end

@implementation TLReadingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [_tableview setDelegate:self];
    [_tableview setDataSource:self];
    [_tableview setAllowsSelection:NO];
    [_tableview setAllowsMultipleSelection:NO];
    [_tableview setAllowsSelectionDuringEditing:NO];
    [_tableview setAllowsMultipleSelectionDuringEditing:NO];
    [_tableview setSeparatorColor:[UIColor redColor]];
    
    [_tableview registerNib:[UINib nibWithNibName:@"TLQuestionTableViewCell" bundle:nil] forCellReuseIdentifier:@"readquestion"];
    
    uDic = [[NSMutableDictionary alloc] initWithCapacity:0];
    
    _dialogView.layer.borderWidth = 1.0;
    _dialogView.layer.cornerRadius = 3.0;
    _dialogView.layer.borderColor = [UIColor grayColor].CGColor;
    
    [_tableview setHidden:YES];
    [_dialogView setHidden:NO];
    
    [self reloadView];
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

-(void)setReadingDictionary:(NSDictionary *)dic{
    _readingDic = dic;
    
    _letter = [_readingDic valueForKey:@"letter"];
    _question = [_readingDic valueForKey:@"question"];
    
    
}

-(void)reloadView{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:_letter ofType:@"rtf"];
    
    _dialogView.attributedText =[[NSAttributedString alloc] initWithFileURL:[NSURL fileURLWithPath:filePath]
                                                                    options:nil
                                                         documentAttributes:nil
                                                                      error:nil];
}

-(void)showAnwser{
    rAnwser = [self findAnwser];
    tAnwser = [_question count];
    
    [super showAnwser];
}

-(NSInteger)findAnwser{
    
    NSInteger count = 0;
    
    NSInteger session = [_tableview numberOfSections];
    for (int i=0; i<session; i++) {
        NSInteger row = [_tableview numberOfRowsInSection:i];
        
        for (int j=0; j<row; j++) {
            NSIndexPath *indexpath = [NSIndexPath indexPathForRow:j inSection:i];
            
            AnwserState anwser = [[uDic objectForKey:indexpath] integerValue];
            
            NSDictionary* itemDic = [_question objectAtIndex:j];
            
            if ([self checkAnwser:anwser valid:[itemDic objectForKey:@"answer"]]) {
                count++;
            }
        }
    }
    
    return count;
}

-(BOOL)checkAnwser:(AnwserState)uAnwser valid:(NSString*)vAnwser{
    
    AnwserState validAnwserSt = kUnknow;
    
    if ([[vAnwser uppercaseString] isEqualToString:@"A"]) {
        validAnwserSt = kAnwserA;
    }
    else if ([[vAnwser uppercaseString] isEqualToString:@"B"]){
        validAnwserSt = kAnwserB;
    }
    else if ([[vAnwser uppercaseString] isEqualToString:@"C"]){
        validAnwserSt = kAnwserC;
    }
    else if ([[vAnwser uppercaseString] isEqualToString:@"D"]){
        validAnwserSt = kAnwserD;
    }
    
    if (uAnwser != validAnwserSt) {
        return NO;
    }
    
    return YES;
}

#pragma mark -
#pragma mark UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_question count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TLQuestionTableViewCell *cell = (TLQuestionTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"readquestion"
                                                                                              forIndexPath:indexPath];
    
    if (!cell) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"readquestion"];
    }
    
    [cell setDelegate:self];
    [cell setQNumber:indexPath.row + 1];
    [cell setData:[_question objectAtIndex:indexPath.row]];
    [cell setIndex:indexPath];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //update data
    AnwserState state = [[uDic objectForKey:indexPath] integerValue];
    [(TLTableViewCellBase*)cell updateSelection:state];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 190;
}

#pragma mark -
#pragma mark - UITableCellView Delegate
-(void)didSelectAnwser:(AnwserState)anwser forCell:(TLTableViewCellBase *)cell{
    
    NSIndexPath *indexpath = [cell index];
    
    [uDic setObject:[NSNumber numberWithInteger:anwser] forKey:indexpath];
}
- (IBAction)showAnwser_Action:(id)sender {
    [self showAnwser];
}

- (IBAction)showQuestion_Action:(id)sender {
    
    [_tableview setHidden:![_tableview isHidden]];
    [_dialogView setHidden:![_dialogView isHidden]];
    
    if ([[sender title] isEqualToString:@"question"]) {
        [sender setTitle:@"script"];
    }
    else{
        [sender setTitle:@"question"];
    }
}
@end
