//
//  commonDefines.h
//  600EST
//
//  Created by Olala on 10/6/17.
//  Copyright © 2017 Olala. All rights reserved.
//

#ifndef commonDefines_h
#define commonDefines_h

#define FONT_SIZE   16
#define FONT_NAME_NORMAL    @""
#define FONT_NAME_SELECTED  @""

#define COLOR_BASE          [UIColor colorWithRed:0.61 green:0.67 blue:0.45 alpha:1.0]
#define COLOR_TEXT          [UIColor whiteColor]

typedef enum : NSUInteger {
    kUnknow  = 0,
    kAnwserA = 1,
    kAnwserB = 2,
    kAnwserC = 3,
    kAnwserD = 4,
} AnwserState;

#endif /* commonDefines_h */
