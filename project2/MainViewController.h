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
@property (nonatomic, weak) IBOutlet UILabel *numberOfRemainingGuessesLabel;
@property (nonatomic, weak) IBOutlet UITextField *submitLetter;

@property (nonatomic, readwrite, strong) NSArray *words;
@property (nonatomic, readwrite, strong) NSString *word;
@property (nonatomic, weak) IBOutlet UILabel *dummyResponse;

- (IBAction)startGame:(id)sender;
- (IBAction)viewHighScores:(id)sender;
- (BOOL)textFieldShouldReturn:(UITextField *)textField;

//- (IBAction)updatePartialWord:(id)sender;
//- (void)show or something to update partialWord and remainingLetters

@end