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

@synthesize remainingLettersLabel=_remainingLettersLabel;
@synthesize numberOfRemainingGuessesLabel=_numberOfRemainingGuessesLabel;
@synthesize words=_words;
@synthesize word=_word;
@synthesize submitLetter = _submitLetter;
@synthesize dummyResponse = _dummyResponse;

- (IBAction)startGame:(id)sender
{
    //alert user with "Are you sure you want to start a new game?"
    //if yes, init new game with current settings
}

- (IBAction)viewHighScores:(id)sender
{
    //show user high score table-list in popup dialog (I think an alert would be fine)
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"words" ofType:@"plist"];
    NSArray *words = [[NSArray alloc] initWithContentsOfFile:path];
    NSUInteger randomIndex = arc4random() % [words count];
    self.word = [words objectAtIndex:randomIndex];
    
    _dummyResponse.text = self.word;
	[self.submitLetter resignFirstResponder];
    return TRUE;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (range.location >= 1)
        return NO; // return NO to not change text
    return YES;
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