//
//  Recording.m
//  CorecVoter
//
//  Created by Liu Di on 9/8/15.
//  Copyright © 2015 CS307. All rights reserved.
//

#import "Recording.h"
#import "Helper.h"
@implementation Recording
+ (NSArray *)allRecordings {
    return @[[Recording recordingsWithName: @"iPhone"],
             [Recording recordingsWithName:@"iPod"],
             [Recording recordingsWithName:@"iPod touch"],
             [Recording recordingsWithName:@"iPod nano"],
             [Recording recordingsWithName:@"iPod classic"],
             [Recording recordingsWithName:@"iPad"],
             [Recording recordingsWithName:@"iPad mini"],
             [Recording recordingsWithName:@"iPad Air"],
             [Recording recordingsWithName:@"iMac"],
             [Recording recordingsWithName:@"Mac Pro"],
             [Recording recordingsWithName:@"Mac mini"]];
}

+ (instancetype) recordingsWithName:(NSString *) name {
    Recording *recording = [[self alloc] init];
    recording.recordingName = name;
    recording.recordingDescription = @"decription";
    recording.voteCount = [Helper randomNumberFrom:0 to:100];
    recording.commentCount = [Helper randomNumberFrom:0 to:10];
    return recording;
}



@end
