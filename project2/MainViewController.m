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

@synthesize remainingLettersLabel, numberOfGuesses, numberOfGuessesLabel, submitLetter, letter, dummyResponse, alphabetArray;

- (IBAction)viewHighScores:(id)sender
{
    //show user high score table-list in popup dialog (I think an alert would be fine)
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    //get letter
    self.letter = [self.submitLetter.text characterAtIndex:0];
    
    //retrieve word list and print dummy response to simulate some sort of gameplay
    NSString *path = [[NSBundle mainBundle] pathForResource:@"words" ofType:@"plist"];
    NSArray *words = [[NSArray alloc] initWithContentsOfFile:path];
    NSUInteger randomIndex = arc4random() % [words count];
    self.dummyResponse.text = [words objectAtIndex:randomIndex];
	
    //update alphabet    
    int length = [self.remainingLettersLabel.text length];
    alphabetArray = [NSMutableString stringWithCapacity: 26];
    
    //replace used chars
    for(int index = 0; index < length; index++) 
    {
        unichar character = [self.remainingLettersLabel.text characterAtIndex:index];
        if (character == self.letter)
            [alphabetArray appendString:@" "];
        else
            [alphabetArray appendFormat: @"%c", character];
    }
    self.remainingLettersLabel.text = alphabetArray;    
    
    //hide keyboard
    [self.submitLetter resignFirstResponder];
    
    //decrement # of guesses every time user enters a letter AND it is incorrect
    self.numberOfGuesses--;
    self.numberOfGuessesLabel.text = [NSString stringWithFormat:@" %d", self.numberOfGuesses];
    
    //end game if user loses
    if (self.numberOfGuesses == 0) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"OH NO!" 
                                                            message:@"You lose!  Joseph is dead!" 
                                                           delegate:self 
                                                  cancelButtonTitle:@"New Game" 
                                                  otherButtonTitles:nil];
        [alertView show];
        [self viewDidLoad];
    }
            
    return YES;
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
    //display number of guesses from user's settings
    self.numberOfGuesses = [[NSUserDefaults standardUserDefaults] integerForKey:@"numberOfGuesses"];
    self.numberOfGuessesLabel.text = [NSString stringWithFormat:@" %d", self.numberOfGuesses];
    
    //create alphabet
    alphabetArray = [NSMutableString stringWithCapacity: 26];
    for(char c = 'A'; c <= 'Z'; c++)
    {
        [alphabetArray appendFormat: @"%c", c];
    }
    //print alphabet to remainingLettersLabel
    self.remainingLettersLabel.text = alphabetArray;
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