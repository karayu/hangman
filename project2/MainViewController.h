//
//  MainViewController.h
//  project2
//
//  Created by Kara Yu on 3/23/12.
//  Copyright (c) 2012 EPIC. All rights reserved.
//

#import "FlipsideViewController.h"

@interface MainViewController : UIViewController <FlipsideViewControllerDelegate>

//not sure about types, pointers, and properties for all of these
@property (nonatomic, weak) IBOutlet UILabel *remainingLettersLabel;
@property (nonatomic, weak) IBOutlet UILabel *numberOfGuessesLabel;
@property IBOutlet UITableView *highScoresTable;
@property IBOutlet UIButton *backButton;
@property (nonatomic, weak) IBOutlet UITextField *submitLetter;
@property (nonatomic, weak) IBOutlet UILabel *dummyResponse;
@property (assign, nonatomic) unsigned int numberOfGuesses;
@property (assign, nonatomic) unsigned int numberOfLetters;
@property unsigned char letter;

@property NSMutableString *alphabetString;
@property NSMutableArray *partialWord;
@property NSMutableArray *highScoresArray;

- (IBAction)viewHighScores:(id)sender;
- (IBAction)startNewGame:(id)sender;

//- (IBAction)updatePartialWord:(id)sender;
//- (void)show or something to update partialWord and remainingLetters

@end