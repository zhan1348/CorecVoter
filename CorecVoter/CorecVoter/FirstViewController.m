//
//  FirstViewController.m
//  CorecVoter
//
//  Created by Liu Di on 8/30/15.
//  Copyright © 2015 CS307. All rights reserved.
//
#import "RecordingTableViewCell.h"
#import "FirstViewController.h"
#import "Recording.h"
#import "Helper.h"
NSString *const oCellIdentifier = @"recordCell";
NSString *const oTableCellNibName = @"RecordingTableViewCell";
//NSArray *const contents = @{@"A",@"B",@"C",@"D",@"E"};
@interface FirstViewController ()

@end

@implementation FirstViewController {
    NSArray *allRecordings;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.recordingTable.delegate = self;
    self.recordingTable.dataSource = self;
    self.recordingTable.rowHeight = 80;
    // Do any additional setup after loading the view, typically from a nib.
    allRecordings = [Recording allRecordings];
    NSLog(@"viewDidload all recordings %@",allRecordings);
    [self.recordingTable registerNib:[UINib nibWithNibName:oTableCellNibName bundle:nil] forCellReuseIdentifier:oCellIdentifier];

    
    _resultSearchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    _resultSearchController.searchResultsUpdater = self;
    _resultSearchController.dimsBackgroundDuringPresentation = false;
    _resultSearchController.searchBar.barTintColor = [UIColor whiteColor];
    _resultSearchController.searchBar.tintColor = [UIColor redColor];
    
    
    
    [_resultSearchController.searchBar sizeToFit];
    
    /** Change custom text */
    /**    [searchBar setValue:@"customString" forKey:@"_cancelButtonText"]; */
    
    self.recordingTable.tableHeaderView = _resultSearchController.searchBar;
    NSArray *familyNames = [[NSArray alloc] initWithArray:[UIFont familyNames]];
    
    NSArray *fontNames;
    NSInteger indFamily, indFont;
    for (indFamily=0; indFamily<[familyNames count]; ++indFamily)
    {
        NSLog(@"Family name: %@", [familyNames objectAtIndex:indFamily]);
        fontNames = [[NSArray alloc] initWithArray:
                     [UIFont fontNamesForFamilyName:
                      [familyNames objectAtIndex:indFamily]]];
        for (indFont=0; indFont<[fontNames count]; ++indFont)
        {
            NSLog(@"    Font name: %@", [fontNames objectAtIndex:indFont]);
        }
    }
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma -mark TableView Delegates

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSLog(@"num of section");
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"num of row");
    if (self.resultSearchController.active) {

        return [self.filteredList count];
    }

    return [allRecordings count];
    
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    return nil;
//}

-(RecordingTableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Recording *recording = nil;
    if (self.resultSearchController.active) {

        recording = [self.filteredList objectAtIndex:indexPath.row];
    }
    else {

        recording = [allRecordings objectAtIndex:indexPath.row];
    }
    RecordingTableViewCell *cell = (RecordingTableViewCell *)[self.recordingTable dequeueReusableCellWithIdentifier:oCellIdentifier forIndexPath:indexPath];
//    Recording *recording = [allRecordings objectAtIndex:indexPath.row];
    NSLog(@"cell name %@",recording.recordingName);

    cell.recordingName.text = recording.recordingName;
    cell.recordingName.font = FONT_Futura_Medium(14);
    cell.recordingDescription.text = recording.recordingDescription;
    cell.recordingDescription.font = FONT_Futura_Medium(12);
    cell.recordingCount.text = [NSString stringWithFormat:@"%d", recording.voteCount];
    cell.recordingCount.font = FONT_Futura_CondenseExtraBold(16);
    [cell.comment setTitle:@"Comment" forState:UIControlStateNormal];
    [cell.comment.titleLabel setFont:FONT_Futura_Medium(12)];
    cell.commentCount.text = [NSString stringWithFormat:@"%d", recording.commentCount];
    cell.commentCount.font = FONT_Futura_Medium(12);
    return cell;

}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    // update the filtered array based on the search text
    NSString *searchText = searchController.searchBar.text;
    NSMutableArray *searchResults = [allRecordings mutableCopy];
    
    // strip out all the leading and trailing spaces
    NSString *strippedString = [searchText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    // break up the search terms (separated by spaces)
    NSArray *searchItems = nil;
    if (strippedString.length > 0) {
        searchItems = [strippedString componentsSeparatedByString:@" "];
    }
    
    // build all the "AND" expressions for each value in the searchString
    //
    NSMutableArray *andMatchPredicates = [NSMutableArray array];
    
    for (NSString *searchString in searchItems) {
        // each searchString creates an OR predicate for: name, yearIntroduced, introPrice
        //
        // example if searchItems contains "iphone 599 2007":
        //      name CONTAINS[c] "iphone"
        //      name CONTAINS[c] "599", yearIntroduced ==[c] 599, introPrice ==[c] 599
        //      name CONTAINS[c] "2007", yearIntroduced ==[c] 2007, introPrice ==[c] 2007
        //
        NSMutableArray *searchItemsPredicate = [NSMutableArray array];
        
        // Below we use NSExpression represent expressions in our predicates.
        // NSPredicate is made up of smaller, atomic parts: two NSExpressions (a left-hand value and a right-hand value)
        
        // name field matching
        NSExpression *lhs = [NSExpression expressionForKeyPath:@"recordingName"];
        NSExpression *rhs = [NSExpression expressionForConstantValue:searchString];
        NSPredicate *finalPredicate = [NSComparisonPredicate
                                       predicateWithLeftExpression:lhs
                                       rightExpression:rhs
                                       modifier:NSDirectPredicateModifier
                                       type:NSContainsPredicateOperatorType
                                       options:NSCaseInsensitivePredicateOption];
        [searchItemsPredicate addObject:finalPredicate];
        
//        lhs = [NSExpression expressionForKeyPath:@"category"];
//        finalPredicate = [NSComparisonPredicate
//                          predicateWithLeftExpression:lhs
//                          rightExpression:rhs
//                          modifier:NSDirectPredicateModifier
//                          type:NSContainsPredicateOperatorType
//                          options:NSCaseInsensitivePredicateOption];
//        [searchItemsPredicate addObject:finalPredicate];
        // at this OR predicate to our master AND predicate
        NSCompoundPredicate *orMatchPredicates = [NSCompoundPredicate orPredicateWithSubpredicates:searchItemsPredicate];
        [andMatchPredicates addObject:orMatchPredicates];
    }
    
    // match up the fields of the Product object
    NSCompoundPredicate *finalCompoundPredicate =
    [NSCompoundPredicate andPredicateWithSubpredicates:andMatchPredicates];
    searchResults = [[searchResults filteredArrayUsingPredicate:finalCompoundPredicate] mutableCopy];
    
    // hand over the filtered results to our search results table
    //    MenuTableResultViewController *tableController = (MenuTableResultViewController *)self.searchController.searchResultsController;
    //    tableController.filteredMenu = searchResults;
    _filteredList = searchResults;

    [self.recordingTable reloadData];
}

#pragma mark - UIStateRestoration

// we restore several items for state restoration:
//  1) Search controller's active state,
//  2) search text,
//  3) first responder

NSString *const ViewControllerTitleKey = @"ViewControllerTitleKey";
NSString *const SearchControllerIsActiveKey = @"SearchControllerIsActiveKey";
NSString *const SearchBarTextKey = @"SearchBarTextKey";
NSString *const SearchBarIsFirstResponderKey = @"SearchBarIsFirstResponderKey";

- (void)encodeRestorableStateWithCoder:(NSCoder *)coder {
    [super encodeRestorableStateWithCoder:coder];
    
    // encode the view state so it can be restored later
    
    // encode the title
    [coder encodeObject:self.title forKey:ViewControllerTitleKey];
    
    UISearchController *searchController = self.resultSearchController;
    
    // encode the search controller's active state
    BOOL searchDisplayControllerIsActive = searchController.isActive;
    [coder encodeBool:searchDisplayControllerIsActive forKey:SearchControllerIsActiveKey];
    
    // encode the first responser status
    if (searchDisplayControllerIsActive) {
        [coder encodeBool:[searchController.searchBar isFirstResponder] forKey:SearchBarIsFirstResponderKey];
    }
    
    // encode the search bar text
    [coder encodeObject:searchController.searchBar.text forKey:SearchBarTextKey];
}

- (void)decodeRestorableStateWithCoder:(NSCoder *)coder {
    [super decodeRestorableStateWithCoder:coder];
    
    // restore the title
    self.title = [coder decodeObjectForKey:ViewControllerTitleKey];
    
    // restore the active state:
    // we can't make the searchController active here since it's not part of the view
    // hierarchy yet, instead we do it in viewWillAppear
    //
    _searchControllerWasActive = [coder decodeBoolForKey:SearchControllerIsActiveKey];
    
    // restore the first responder status:
    // we can't make the searchController first responder here since it's not part of the view
    // hierarchy yet, instead we do it in viewWillAppear
    //
    _searchControllerSearchFieldWasFirstResponder = [coder decodeBoolForKey:SearchBarIsFirstResponderKey];
    
    // restore the text in the search field
    self.resultSearchController.searchBar.text = [coder decodeObjectForKey:SearchBarTextKey];
}

@end
