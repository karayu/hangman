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

- (IBAction)startGame:(id)sender
{
    //alert user with "Are you sure you want to start a new game?"
    //if yes, init new game with current settings
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

@interface TextField ()

@end

@implementation TextField

@synthesize words=_words;
@synthesize partialWord=_partialWord;

- (void)viewDidLoad 
{
    [super viewDidLoad];
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
// Tell the keyboard where to go on next / go button.
    NSString *path = [[NSBundle mainBundle] pathForResource:@"small" ofType:@"plist"];
    NSArray *words = [[NSArray alloc] initWithContentsOfFile:path];
    NSUInteger randomIndex = arc4random() % [words count];
    self.words = [words objectAtIndex:randomIndex];

    _partialWord.text = [NSString stringWithFormat:@" %s", self.words];
	[textField resignFirstResponder];

return YES;
}

@end