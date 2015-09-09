//
//  FirstViewController.h
//  CorecVoter
//
//  Created by Liu Di on 8/30/15.
//  Copyright © 2015 CS307. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstViewController : UIViewController<UISearchResultsUpdating, UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITableView *recordingTable;
@property (strong, nonatomic) UISearchController *resultSearchController;
@property BOOL searchControllerWasActive;
@property BOOL searchControllerSearchFieldWasFirstResponder;
@property NSMutableArray *filteredList;
@end

