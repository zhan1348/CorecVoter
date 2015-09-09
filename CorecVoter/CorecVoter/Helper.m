//
//  Helper.m
//  CorecVoter
//
//  Created by Liu Di on 9/8/15.
//  Copyright © 2015 CS307. All rights reserved.
//

#import "Helper.h"

@implementation Helper
+ (int) randomNumberFrom:(int)from to:(int)to {
    if (from > to) {
        return 0;
    }
    //range from 50 to 100
//    int num1 = (arc4random() % 50) + 50; or
    return arc4random_uniform(to - from) + from;
    
    //range from 0-100
//    int num1 = arc4random() % 100; or
//    int num1 = arc4random_uniform(100);
}
@end
