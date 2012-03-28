//
//  MainViewController.h
//  project2
//
//  Created by Kara Yu on 3/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FlipsideViewController.h"

@interface MainViewController : UIViewController <FlipsideViewControllerDelegate>

//not sure about types, pointers, and properties for all of these
@property (assign, nonatomic) char *partialWord;
@property (nonatomic, weak) IBOutlet UILabel *remainingLettersLabel;
@property (nonatomic, weak) IBOutlet UILabel *numberOfRemainingGuessesLabel;

- (IBAction)startGame:(id)sender;
- (IBAction)viewHighScores:(id)sender;
- (IBAction)updatePartialWord:(id)sender;
//- (void)show or something to update partialWord and remainingLetters ?

@end
