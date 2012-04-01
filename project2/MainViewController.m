//
//  MainViewController.m
//  project2
//
//  Created by Kara Yu on 3/23/12.
//  Copyright (c) 2012 EPIC. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

@synthesize remainingLettersLabel, numberOfGuesses, numberOfGuessesLabel, submitLetter, dummyResponse;

- (IBAction)startGame:(id)sender
{
    //alert user with "Are you sure you want to start a new game?"
    //if yes, init new game with current settings
}

- (IBAction)viewHighScores:(id)sender
{
    //show user high score table-list in popup dialog (I think an alert would be fine)
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"words" ofType:@"plist"];
    NSArray *words = [[NSArray alloc] initWithContentsOfFile:path];
    NSUInteger randomIndex = arc4random() % [words count];
    
    self.dummyResponse.text = [words objectAtIndex:randomIndex];
	[self.submitLetter resignFirstResponder];
    return TRUE;
}

//allows only one character in the submitLetter textField
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    //if there is already a character in the textField, don't allow anymore to be typed
    if (range.location >= 1)
        return NO;
    
    //if got to this point, there are 0 characters in textField so we allow one to be typed
    return YES;
}

- (void)viewDidLoad
{
    self.numberOfGuesses = [[NSUserDefaults standardUserDefaults] integerForKey:@"numberOfGuesses"];
    self.numberOfGuessesLabel.text = [NSString stringWithFormat:@" %d", self.numberOfGuesses]; 
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - Flipside View

- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller
{
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)showInfo:(id)sender
{    
    FlipsideViewController *controller = [[FlipsideViewController alloc] initWithNibName:@"FlipsideViewController" bundle:nil];
    controller.delegate = self;
    controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentModalViewController:controller animated:YES];
}

@end