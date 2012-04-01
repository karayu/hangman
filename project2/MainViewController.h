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
@property (assign, nonatomic) unsigned int numberOfGuesses;
@property (nonatomic, weak) IBOutlet UITextField *submitLetter;
@property (nonatomic, weak) IBOutlet UILabel *dummyResponse;
@property unsigned char letter;
@property NSMutableString *alphabetArray;

- (IBAction)viewHighScores:(id)sender;


//- (IBAction)updatePartialWord:(id)sender;
//- (void)show or something to update partialWord and remainingLetters

@end