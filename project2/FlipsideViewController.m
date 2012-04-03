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

@synthesize delegate, numberOfGuesses, numberOfLetters, isEvil, numberOfGuessesLabel, numberOfLettersLabel,numberOfGuessesSlider, numberOfLettersSlider, evilSwitch, Evil, Good;

- (void)viewDidLoad
{
    //store guesses/letters from user's saved defaults in temporary instance variables
    //???have some alternate value in case there are not yet any user defaults?
    self.numberOfGuesses = [[NSUserDefaults standardUserDefaults] integerForKey:@"numberOfGuesses"];
    self.numberOfLetters = [[NSUserDefaults standardUserDefaults] integerForKey:@"numberOfLetters"];
    self.isEvil = [[NSUserDefaults standardUserDefaults] boolForKey:@"evil"];
    
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

    //toggle switch based on whether evil or not
    self.evilSwitch.on = self.isEvil;
}

#pragma mark - Actions

- (IBAction)slidersChanged:(id)sender 
{  
    //update instance variables for numbers based on current slider values
    self.numberOfGuesses = self.numberOfGuessesSlider.value;
    self.numberOfLetters = self.numberOfLettersSlider.value;
    
    //update instance variable for evil
    self.isEvil = self.evilSwitch.isOn;
    
    //call show to display the slider values in numeric form
    [self show];
}  

- (IBAction)done:(id)sender
{
    //save the default variables as user's defaults
    [[NSUserDefaults standardUserDefaults] setInteger:self.numberOfGuesses forKey:@"numberOfGuesses"];
    [[NSUserDefaults standardUserDefaults] setInteger:self.numberOfLetters forKey:@"numberOfLetters"];
    
    
    //set evil as "YES" or "NO" based on if switch is on or off
    if ([self.evilSwitch isOn]) 
    {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"evil"];
    }
    else 
    {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"evil"];
    }
    
    //return to default controller with saved defaults
    [self.delegate flipsideViewControllerDidFinish:self];
}

@end
