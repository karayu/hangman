//
//  FlipsideViewController.m
//  project2
//
//  Created by Kara Yu on 3/23/12.
//  Copyright (c) 2012 EPIC. All rights reserved.
//

#import "FlipsideViewController.h"
#import "EvilGamePlay.h"
#import "GoodGamePlay.h"

@interface FlipsideViewController ()

@end

@implementation FlipsideViewController

@synthesize delegate, numberOfGuesses, numberOfLetters, isEvil, numberOfGuessesLabel, numberOfLettersLabel,numberOfGuessesSlider, numberOfLettersSlider, evilSwitch, Evil, Good;

- (void)viewDidLoad
{    
    //store guesses/letters from user's saved defaults in temporary instance variables
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

//check the max word length of good and evil to be sure the user's settings are allowed
- (BOOL)checkWordLengths
{
    //alert user if word length is not allowed for a given dictionary
    if (((self.isEvil) && ![self.Evil setWordLength]) || (!(self.isEvil) && ![self.Good setWordLength]))
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"WAIT!" 
                                                            message:@"That word length is not allowed, please fix it before continuing!" 
                                                           delegate:self 
                                                  cancelButtonTitle:@"Close" 
                                                  otherButtonTitles:nil];
        [alertView show];     
    }
    //return true if word lengths are allowed
    else 
    {
        return YES;
    }
    return NO;
}

#pragma mark - Actions

//plant an event listener to update instance variables when sliders or switch are changed
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

//when user is done editing settings, save final variables as defaults
- (IBAction)done:(id)sender
{
    //save the default variables as user's defaults
    [[NSUserDefaults standardUserDefaults] setInteger:self.numberOfGuesses forKey:@"numberOfGuesses"];
    [[NSUserDefaults standardUserDefaults] setInteger:self.numberOfLetters forKey:@"numberOfLetters"];
    
    //set evil as "YES" or "NO" based on if switch is on or off
    if ([self.evilSwitch isOn])
    {
        self.Evil = [[EvilGamePlay alloc] init];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"evil"];
    }
    else 
    {
        self.Good = [[GoodGamePlay alloc] init];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"evil"];
    }
    
    //return to default controller with saved defaults
    if ([self checkWordLengths])
        [self.delegate flipsideViewControllerDidFinish:self];
}

@end
