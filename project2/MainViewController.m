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

@synthesize partialWord=_partialWord;
@synthesize remainingLettersLabel=_remainingLettersLabel;
@synthesize numberOfRemainingGuessesLabel=_numberOfRemainingGuessesLabel;

- (IBAction)startGame:(id)sender
{
    //alert user with "Are you sure you want to start a new game?"
    //if yes, init new game with current settings
}

- (IBAction)updatePartialWord:(id)sender
{
    //show user keyboard when they touch the label
    //user submits letter
    //call algorithm
    //return letter or not letter
    //update # of guesses, # of incorrect guesses, and used letters
}

- (IBAction)viewHighScores:(id)sender
{
    //show user high score table-list in popup dialog (I think an alert would be fine)
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
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
