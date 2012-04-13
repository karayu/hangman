//
//  HighScoresViewController.h
//  project2
//
//  Created by Kara Yu on 4/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@class HighScoresViewController;

@protocol HighScoresViewControllerDelegate
- (void)highScoresViewControllerDidFinish:(HighScoresViewController *)controller;
@end

@interface HighScoresViewController : UITableViewController

//variables
@property (nonatomic, strong) NSNumber *maxHighScores;
@property (nonatomic, strong) NSMutableArray *highScoresArray;

//UI widgets
@property (nonatomic, strong) IBOutlet UITableView *tableView;

//delegate
@property (weak, nonatomic) id <HighScoresViewControllerDelegate> delegate; 


//classes
- (void)viewDidLoad;
- (void)viewDidUnload;
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation;

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;


@end