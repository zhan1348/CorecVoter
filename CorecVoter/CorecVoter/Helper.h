//
//  Helper.h
//  CorecVoter
//
//  Created by Liu Di on 9/8/15.
//  Copyright © 2015 CS307. All rights reserved.
//

#import <Foundation/Foundation.h>
#define FONT_Futura_Medium(s) [UIFont fontWithName:@"Futura-Medium" size:s]
#define FONT_Futura_CondenseExtraBold(s) [UIFont fontWithName:@"Futura-CondensedExtraBold" size:s]
@interface Helper : NSObject

+ (int) randomNumberFrom:(int) from to:(int)to;
@end
