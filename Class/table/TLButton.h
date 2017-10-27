//
//  TLButton.h
//  
//
//  Created by NguyenThanhLuan on 21/02/2017.
//
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    TButton_State_None,
    TButton_State_Select,
    TButton_State_Unselect,
} TButtonState;

typedef enum : NSUInteger {
    TButton_None,
    TButton_A,
    TButton_B,
    TButton_C,
    TButton_D,
} TButtonCategory;

@interface TLButton : UIButton

@property (nonatomic, assign) TButtonState      buttonState;
@property (nonatomic, assign) TButtonCategory   buttonCategory;
@property (nonatomic, strong) UIView            *checkBox;

@end
