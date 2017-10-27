//
//  TLListeningViewController.m
//  600EST
//
//  Created by NguyenThanhLuan on 16/02/2017.
//  Copyright © 2017 Olala. All rights reserved.
//

#import "TLListeningViewController.h"
#import "TLQuestionTableViewCell.h"
#import "TLPhotoCollectionViewCell.h"
#import "TLQnRCollectionViewCell.h"
#import "TLQuestionCollectionViewCell.h"

@import EZLoadingActivity;
@import AnimatedCollectionViewLayout;

@interface TLListeningViewController (){
    CategoryFile _category;
    BOOL isShowAnwser;
}

@end

@implementation TLListeningViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.navigationItem setTitle:@"Listening"];
    
    [_collectview setDelegate:self];
    [_collectview setDataSource:self];
    [_collectview setPagingEnabled:YES];
    [_collectview setBackgroundColor:[UIColor colorWithRed:193.0f/255.0f green:193.0f/255.0f blue:193.0f/255.0f alpha:1.0f]];
    
    [_collectview registerNib:[UINib nibWithNibName:@"TLPhotoCollectionviewCell" bundle:nil] forCellWithReuseIdentifier:@"idphoto"];
    [_collectview registerNib:[UINib nibWithNibName:@"TLQnRCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"idqnr"];
    [_collectview registerNib:[UINib nibWithNibName:@"TLQuestionCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"idquestion"];
    
    uDic = [[NSMutableDictionary alloc] initWithCapacity:0];
    
    _category = kCategory_Internet;
    
    [_playerBar setPlayerURL:_audio];
    [_playerBar setPlayerBarDelegate:self];
    [_playerBar setCategory:_category];
    [_playerBar loadContent];
    
    isShowAnwser = NO;
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

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
#warning Incomplete implementation, return the number of sections
    return 4;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of items
    
    if (section == 0) {
        return 1;   //photo 1 object
    }
    else if (section == 1){
        return 1;  //QnR 1 object
    }
    else if (section == 2){
        return [_conversation count];
    }
    else if (section == 3){
        return [_talk count];
    }
    
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        TLPhotoCollectionViewCell *cell = (TLPhotoCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"idphoto" forIndexPath:indexPath];
        
        // Configure the cell
        cell.backgroundColor = [UIColor whiteColor];
        
        [cell setDelegate:self];
        [cell setIndex:indexPath];
        [cell setTitle:@"Photo"];
        [cell setPhotoData:_photo];
        
        return cell;
    }
    else if (indexPath.section == 1)
    {
        //idqnr
        
        TLQnRCollectionViewCell *cell = (TLQnRCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"idqnr" forIndexPath:indexPath];
        
        //configure the cell
        cell.backgroundColor = [UIColor whiteColor];
        
        [cell setDelegate:self];
        [cell setIndex:indexPath];
        [cell setTitle:@"Question & Response"];
        [cell setQnRdata:_questionNresponse];
        
        return cell;
    }
    else if (indexPath.section == 2){
        TLQuestionCollectionViewCell *cell = (TLQuestionCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"idquestion" forIndexPath:indexPath];
        
        cell.backgroundColor = [UIColor whiteColor];
        
        [cell setDelegate:self];
        [cell setIndex:indexPath];
        [cell setTitle:@"Conversation"];
        [cell setupQuestionData:[_conversation objectAtIndex:indexPath.row]];
        
        return cell;
    }
    else if (indexPath.section == 3){
        TLQuestionCollectionViewCell *cell = (TLQuestionCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"idquestion" forIndexPath:indexPath];
        
        cell.backgroundColor = [UIColor whiteColor];
        
        [cell setDelegate:self];
        [cell setIndex:indexPath];
        [cell setTitle:@"Short Talk"];
        [cell setupQuestionData:[_talk objectAtIndex:indexPath.row]];
        
        return cell;
    }
    
    return nil;
}

-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    //update data
    
    AnwserState state = [[uDic objectForKey:indexPath] integerValue];
    
    [(TLCollectionViewCellBase*)cell hideCheckAnwser];
    
    if ([cell isKindOfClass:[TLQnRCollectionViewCell class]]) {
        [(TLCollectionViewCellBase*)cell setIndex:indexPath];
        [(TLCollectionViewCellBase*)cell updateSelection:state];
        
        indexPath = [NSIndexPath indexPathForRow:1 inSection:indexPath.section];
        state = [[uDic objectForKey:indexPath] integerValue];
        
        [(TLCollectionViewCellBase*)cell setIndex:indexPath];
        [(TLCollectionViewCellBase*)cell updateSelection:state];
    }
    else{
        [(TLCollectionViewCellBase*)cell setIndex:indexPath];
        [(TLCollectionViewCellBase*)cell updateSelection:state];
    }
    
    if (isShowAnwser) {
        [(TLCollectionViewCellBase*)cell showAnwser];
    }
}

#pragma mark <UICollectionViewLayoutDelegate>
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(collectionView.bounds.size.width/1, collectionView.bounds.size.height/1);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsZero;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return 0;
}

#pragma mark - 
#pragma mark - Collection Cell View
-(void)didSelectAnwser:(AnwserState)anwser forCell:(TLCollectionViewCellBase *)cell{
    
    NSIndexPath *indexpath = [cell index];
    [uDic setObject:[NSNumber numberWithInteger:anwser] forKey:indexpath];
}


#pragma mark - Player Bar Delegate
-(void)didClickPlayer:(CategoryFile)filetype{
    
    if (filetype == kCategory_Internet) {
        [EZLoadingActivity show:@"Loading ..." disableUI:YES];
    }
    
    isShowAnwser = NO;
    
    [_collectview reloadData];
}

-(void)didClickReplayPlayer:(CategoryFile)filetype{
    
    if (isShowAnwser) {
        isShowAnwser = NO;
        
        [uDic removeAllObjects];
        [_collectview reloadData];
    }
}

-(void)didFinishPlayer:(CategoryFile)filetype{
    //show score
    NSLog(@"Show score");
    
    isShowAnwser = YES;
    
    NSInteger count = 0;
    
    NSInteger session = [_collectview numberOfSections];
    for (int i=0; i<session; i++) {
        NSInteger row = [_collectview numberOfItemsInSection:i];
        
        for (int j=0; j<row; j++) {
            NSIndexPath *indexpath = [NSIndexPath indexPathForRow:j inSection:i];
            
            AnwserState state = [[uDic objectForKey:indexpath] integerValue];
            
            NSString *strValid = @"";
            
            switch (i) {
                case 0:
                    strValid = [_photo objectForKey:@"answer"];
                    break;
                case 1:
                    strValid = [_questionNresponse objectAtIndex:0];
                    if ([self checkAnwser:state valid:strValid]) {
                        count++;
                    }
                    
                    state = [[uDic objectForKey:[NSIndexPath indexPathForRow:1 inSection:indexpath.section]] integerValue];
                    strValid = [_questionNresponse objectAtIndex:1];
                    break;
                case 2:
                    strValid = [[_conversation objectAtIndex:j] valueForKey:@"answer"];
                    break;
                case 3:
                    strValid = [[_talk objectAtIndex:j] valueForKey:@"answer"];
                    break;
                default:
                    break;
            }
            
            if ([self checkAnwser:state valid:strValid]) {
                count++;
            }
        }
    }
    
    tAnwser = 0;
    rAnwser = 0;
    
    tAnwser = 1 + 2 + _conversation.count + _talk.count;
    rAnwser = count;
    
    [self showAnwser];
    
    NSDictionary *lessonDic = [[NSUserDefaults standardUserDefaults] objectForKey:lessonName];
    NSMutableDictionary *lessonMutableDic = [[NSMutableDictionary alloc] initWithDictionary:lessonDic];
    [lessonMutableDic setValue:[NSNumber numberWithInteger:rAnwser] forKey:@"listening"];
    
    [[NSUserDefaults standardUserDefaults] setObject:lessonMutableDic forKey:lessonName];
    
    [_collectview reloadData];
}

-(void)didReadyPlayer:(CategoryFile)filetype ready:(BOOL)ready{
    
    if (filetype == kCategory_Internet) {
        if (ready == YES) {
            [EZLoadingActivity hide:YES animated:YES];
        }
        else{
            [EZLoadingActivity hide:NO animated:YES];
        }
    }
}

-(void)didUpdateCurrentTime:(NSTimeInterval)ctime{
    
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
@end
