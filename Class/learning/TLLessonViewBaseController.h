//
//  TLLessonViewBaseController.h
//  600EST
//
//  Created by NguyenThanhLuan on 15/02/2017.
//  Copyright © 2017 Olala. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TLLessonViewBaseController : UIViewController{
    
    NSString        *_vocabFile;
    NSDictionary    *_listeningDic;
    NSArray         *_incompleteArr;
    NSDictionary    *_readingDic;
    
    NSInteger       rAnwser;
    NSInteger       tAnwser;
}

-(void)setVocabFile:(NSString*)file;
-(void)setListeningDictionary:(NSDictionary*)dic;
-(void)setIncompleteArray:(NSArray*)arr;
-(void)setReadingDictionary:(NSDictionary*)dic;

-(void)reloadView;
-(void)showAnwser;

@end
