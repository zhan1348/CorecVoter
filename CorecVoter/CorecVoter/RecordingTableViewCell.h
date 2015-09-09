//
//  RecordingTableViewCell.h
//  CorecVoter
//
//  Created by Liu Di on 9/8/15.
//  Copyright © 2015 CS307. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecordingTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *upVote;
@property (weak, nonatomic) IBOutlet UIButton *downVote;
@property (weak, nonatomic) IBOutlet UIButton *comment;
@property (weak, nonatomic) IBOutlet UILabel *commentCount;
@property (weak, nonatomic) IBOutlet UILabel *recordingName;
@property (weak, nonatomic) IBOutlet UILabel *recordingDescription;
@property (weak, nonatomic) IBOutlet UILabel *recordingCount;

@end
