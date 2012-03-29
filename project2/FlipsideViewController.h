//
//  FlipsideViewController.h
//  project2
//
//  Created by Kara Yu on 3/23/12.
//  Copyright (c) 2012 EPIC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FlipsideViewController;

@protocol FlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller;
@end

@interface FlipsideViewController : UIViewController

@property (weak, nonatomic) id <FlipsideViewControllerDelegate> delegate;  
@property (nonatomic, retain) IBOutlet UILabel *numberOfGuessesLabel;
@property (nonatomic, retain) IBOutlet UILabel *numberOfLettersLabel;
@property (assign, nonatomic) unsigned int numberOfGuesses;
@property (assign, nonatomic) unsigned int numberOfLetters;

- (IBAction)numberOfGuessesSliderChanged:(id)sender; 
- (IBAction)numberOfLettersSliderChanged:(id)sender; 
- (IBAction)done:(id)sender;
- (void)show;

@end
