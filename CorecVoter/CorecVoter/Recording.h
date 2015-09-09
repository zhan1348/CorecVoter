//
//  Recording.h
//  CorecVoter
//
//  Created by Liu Di on 9/8/15.
//  Copyright © 2015 CS307. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Recording : NSObject
@property (nonatomic, copy) NSString *recordingName;
@property (nonatomic, copy) NSString *recordingDescription;
@property int voteCount;
@property int commentCount;
+(NSArray *) allRecordings;

@end
