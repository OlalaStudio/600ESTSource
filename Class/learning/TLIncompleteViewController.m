//
//  TLIncompleteViewController.m
//  600EST
//
//  Created by NguyenThanhLuan on 15/02/2017.
//  Copyright © 2017 Olala. All rights reserved.
//

#import "TLIncompleteViewController.h"
#import "TLQuestionTableViewCell.h"

@interface TLIncompleteViewController ()

@end

@implementation TLIncompleteViewController

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
    
    [_tableview registerNib:[UINib nibWithNibName:@"TLQuestionTableViewCell" bundle:nil] forCellReuseIdentifier:@"completequestion"];
    
    uDic = [[NSMutableDictionary alloc] initWithCapacity:0];
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

-(void)setIncompleteArray:(NSArray *)arr{
    _incompleteArr = arr;
}

-(void)reloadView{
    
}

-(void)showAnwser{
    rAnwser = [self findAnwser];
    tAnwser = [_incompleteArr count];
    
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
            
            NSDictionary* itemDic = [_incompleteArr objectAtIndex:j];
            
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
    return [_incompleteArr count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TLQuestionTableViewCell *cell = (TLQuestionTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"completequestion"
                                                                                              forIndexPath:indexPath];
    
    if (!cell) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"completequestion"];
    }
    
    [cell setDelegate:self];
    [cell setQNumber:indexPath.row + 1];
    [cell setData:[_incompleteArr objectAtIndex:indexPath.row]];
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
@end
