//
//  TLListeningViewController.m
//  600EST
//
//  Created by NguyenThanhLuan on 16/02/2017.
//  Copyright © 2017 Olala. All rights reserved.
//

#import "TLListeningViewController.h"
#import "TLPhotoTableViewCell.h"
#import "TLQnRTableViewCell.h"
#import "TLQuestionTableViewCell.h"

@interface TLListeningViewController ()

@end

@implementation TLListeningViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [_tableview setDelegate:self];
    [_tableview setDataSource:self];
    
    [_tableview registerNib:[UINib nibWithNibName:@"TLPhotoTableViewCell" bundle:nil] forCellReuseIdentifier:@"photocell"];
    [_tableview registerNib:[UINib nibWithNibName:@"TLQnRTableViewCell" bundle:nil] forCellReuseIdentifier:@"qnr"];
    [_tableview registerNib:[UINib nibWithNibName:@"TLQuestionTableViewCell" bundle:nil] forCellReuseIdentifier:@"conversation"];
    
    uDic = [[NSMutableDictionary alloc] initWithCapacity:0];
    
    [_playerBar setPlayerURL:_audio];
    [_playerBar setPlayerBarDelegate:self];
    [_playerBar loadContent];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated{
    [_playerBar pause];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)setListeningDictionary:(NSDictionary *)dic{
    _listeningDic = dic;
    
    _audio = [_listeningDic objectForKey:@"audio"];
    _photo = [_listeningDic objectForKey:@"photo"];
    _conversation = [_listeningDic objectForKey:@"conversation"];
    _questionNresponse = [_listeningDic objectForKey:@"questionandresponse"];
    _talk = [_listeningDic objectForKey:@"talk"];
}

-(void)reloadView{
    
}

-(void)showAnwser{
    rAnwser = [self findAnwser];
    tAnwser = 1 + 2  + [_conversation count] + [_talk count];
    
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
            
            NSString *vAnwser;
            if (i == 0) { //photo
              vAnwser = [_photo valueForKey:@"answer"];
            }
            else if (i == 1){//question and response
                vAnwser = [_questionNresponse objectAtIndex:j];
            }
            else if (i == 2){//conversation
                NSDictionary *itemDic = [_conversation objectAtIndex:j];
                vAnwser = [itemDic valueForKey:@"answer"];
            }
            else if (i == 3){//short talk
                NSDictionary *itemDic = [_talk objectAtIndex:j];
                vAnwser = [itemDic valueForKey:@"answer"];
            }
            
            if ([self checkAnwser:anwser valid:vAnwser]) {
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
    return 4;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 1;
    }
    else if (section == 1){
        return 2;
    }
    else if (section == 2 || section == 3){
        return 3;
    }
    
    return 0;
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return @"Photo";
    }
    else if (section == 1){
        return @"Question and Response";
    }
    else if (section == 2){
        return @"Conversation";
    }
    else if (section == 3){
        return @"Short Talk";
    }
    
    return @"";
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) { //photo
        TLPhotoTableViewCell *cell = [_tableview dequeueReusableCellWithIdentifier:@"photocell"];
        [cell setDelegate:self];
        [cell setQNumber:indexPath.row + 1];
        [cell setData:_photo];
        [cell setIndex:indexPath];
        
        return cell;
    }
    else if (indexPath.section == 1){ //Question and Response
        TLQnRTableViewCell *cell = [_tableview dequeueReusableCellWithIdentifier:@"qnr"];
        [cell setDelegate:self];
        [cell setQNumber:indexPath.section + indexPath.row + 1];
        [cell setData:[_questionNresponse objectAtIndex:indexPath.row]];
        [cell setIndex:indexPath];
        
        return cell;
    }
    else if(indexPath.section == 2){//Conversation
        TLQuestionTableViewCell *cell = [_tableview dequeueReusableCellWithIdentifier:@"conversation"];
        [cell setDelegate:self];
        [cell setQNumber:indexPath.section * 2 + indexPath.row];
        [cell setData:[_conversation objectAtIndex:indexPath.row]];
        [cell setIndex:indexPath];
        
        return cell;
    }
    else if (indexPath.section == 3){//short talk
        TLQuestionTableViewCell *cell = [_tableview dequeueReusableCellWithIdentifier:@"conversation"];
        [cell setDelegate:self];
        [cell setQNumber:indexPath.section*2 + indexPath.row + 1];
        [cell setData:[_talk objectAtIndex:indexPath.row]];
        [cell setIndex:indexPath];
        
        return cell;
    }
    
    return nil;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //update data
    AnwserState state = [[uDic objectForKey:indexPath] integerValue];
    [(TLTableViewCellBase*)cell updateSelection:state];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return 150;
    }
    else if (indexPath.section == 1){
        return 100;
    }
    else if (indexPath.section == 2){
        return 190;
    }
    else if (indexPath.section == 3){
        return 190;
    }
    
    return 150;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 32;
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

#pragma mark - Player Bar Delegate
-(void)didFinishPlayer{
    
    //show score
    NSLog(@"Show score");
    
    [self showAnwser];
}

-(void)didClickPlayer
{

}

-(void)canClickPlayer
{
    
}
@end
