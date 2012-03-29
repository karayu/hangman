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

- (void)viewDidLoad
{
    self.numberOfGuesses = 7;
    self.numberOfLetters = 4;
    [self show];
	// Do any additional setup after loading the view, typically from a nib.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)show
{
    //show number of guesses in numeric form
    self.numberOfGuessesLabel.text = [NSString stringWithFormat:@" %d", self.numberOfGuesses];  
    
    //show number of letters in numeric form
    self.numberOfLettersLabel.text = [NSString stringWithFormat:@" %d", self.numberOfLetters];  
    
}

#pragma mark - Actions

- (IBAction) numberOfGuessesSliderChanged:(UISlider *)sender {  
    UISlider *slider =  (UISlider *)sender;
    self.numberOfGuesses = slider.value;
    
    //show
    [self show];
}  

- (IBAction) numberOfLettersSliderChanged:(UISlider *)sender {  
    UISlider *slider =  (UISlider *)sender;
    self.numberOfLetters = slider.value;
    [self show];
}  

- (IBAction)done:(id)sender
{
    [self.delegate flipsideViewControllerDidFinish:self];
}

@end
