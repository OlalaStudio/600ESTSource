//
//  TLButton.m
//  
//
//  Created by NguyenThanhLuan on 21/02/2017.
//
//

#import "TLButton.h"

@interface TLButton (){
 
}

@end

@implementation TLButton
@synthesize buttonState = _buttonState;
@synthesize buttonCategory = _buttonCategory;

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}

-(void)awakeFromNib{
    [super awakeFromNib];
    
    _buttonState = TButton_State_Unselect;
    
    switch (self.buttonCategory) {
        case TButton_A:
            [self setImage:[UIImage imageNamed:@"btAunselect"] forState:UIControlStateNormal];
            break;
        case TButton_B:
            [self setImage:[UIImage imageNamed:@"btBunselect"] forState:UIControlStateNormal];
            break;
        case TButton_C:
            [self setImage:[UIImage imageNamed:@"btCunselect"] forState:UIControlStateNormal];
            break;
        case TButton_D:
            [self setImage:[UIImage imageNamed:@"btDunselect"] forState:UIControlStateNormal];
            break;
        default:
            break;
    }
}

-(void)setButtonCategory:(TButtonCategory)buttonCategory{
    _buttonCategory = buttonCategory;
}

-(TButtonCategory)buttonCategory{
    return _buttonCategory;
}

-(void)setButtonState:(TButtonState)buttonState{
    _buttonState = buttonState;
    
    switch (self.buttonCategory) {
        case TButton_A:
            if (_buttonState == TButton_State_Select) {
                [self setImage:[UIImage imageNamed:@"btAselected"] forState:UIControlStateNormal];
            }
            else{
                [self setImage:[UIImage imageNamed:@"btAunselect"] forState:UIControlStateNormal];
            }
            break;
        case TButton_B:
            if (_buttonState == TButton_State_Select) {
                [self setImage:[UIImage imageNamed:@"btBselected"] forState:UIControlStateNormal];
            }
            else{
                [self setImage:[UIImage imageNamed:@"btBunselect"] forState:UIControlStateNormal];
            }
            break;
        case TButton_C:
            if (_buttonState == TButton_State_Select) {
                [self setImage:[UIImage imageNamed:@"btCselected"] forState:UIControlStateNormal];
            }
            else{
                [self setImage:[UIImage imageNamed:@"btCunselect"] forState:UIControlStateNormal];
            }
            break;
        case TButton_D:
            if (_buttonState == TButton_State_Select) {
                [self setImage:[UIImage imageNamed:@"btDselected"] forState:UIControlStateNormal];
            }
            else{
                [self setImage:[UIImage imageNamed:@"btDunselect"] forState:UIControlStateNormal];
            }
            break;
        default:
            break;
    }
}

-(TButtonState)buttonState{
    return _buttonState;
}
@end
