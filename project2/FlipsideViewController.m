//
//  FlipsideViewController.m
//  project2
//
//  Created by Kara Yu on 3/23/12.
//  Copyright (c) 2012 EPIC. All rights reserved.
//

#import "FlipsideViewController.h"

@interface FlipsideViewController ()

@end

@implementation FlipsideViewController

@synthesize delegate = _delegate;
@synthesize numberOfGuesses = _numberOfGuesses;
@synthesize numberOfLetters = _numberOfLetters;
@synthesize numberOfGuessesLabel = _numberOfGuessesLabel;
@synthesize numberOfLettersLabel = _numberOfLettersLabel;
@synthesize numberOfGuessesSlider = _numberOfGuessesSlider;
@synthesize numberOfLettersSlider = _numberOfLettersSlider;

- (void)viewDidLoad
{
    //get number of guesses/letters from user's saved defaults
    //???have some alternate value in case there are not yet any user defaults?
    self.numberOfGuesses = [[NSUserDefaults standardUserDefaults] integerForKey:@"numberOfGuesses"];
    self.numberOfLetters = [[NSUserDefaults standardUserDefaults] integerForKey:@"numberOfLetters"];
    
    //display the default number of guesses/letters in numeric form and in the sliders
    [self show];
}

- (void)show
{
    //show number of guesses in numeric form & in slider
    self.numberOfGuessesLabel.text = [NSString stringWithFormat:@" %d", self.numberOfGuesses];  
    self.numberOfGuessesSlider.value = self.numberOfGuesses;
    
    //show number of letters in numeric form & in slider
    self.numberOfLettersLabel.text = [NSString stringWithFormat:@" %d", self.numberOfLetters];
    self.numberOfLettersSlider.value = self.numberOfLetters;
}

#pragma mark - Actions

- (IBAction) slidersChanged:(id)sender 
{  
    //reset default variables based on current slider values
    self.numberOfGuesses = self.numberOfGuessesSlider.value;
    self.numberOfLetters = self.numberOfLettersSlider.value;
    
    //call show to display the slider values in numeric form
    [self show];
}  

- (IBAction)done:(id)sender
{
    //save the default variables as user's defaults
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:self.numberOfGuesses forKey:@"numberOfGuesses"];
    [defaults setInteger:self.numberOfLetters forKey:@"numberOfLetters"];
    
    //return to default controller with saved defaults
    [self.delegate flipsideViewControllerDidFinish:self];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
