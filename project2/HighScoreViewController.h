//
//  HighScoreViewControllerViewController.h
//  project2
//
//  Created by Kara Yu on 4/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HighScoreViewController : UITableViewController

@property (nonatomic, strong) NSNumber *maxHighScores;
@property (nonatomic, strong) NSMutableArray *highScoresArray;

@property (nonatomic, strong) IBOutlet UITableView *tableview;

@end
