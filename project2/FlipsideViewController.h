//
//  FlipsideViewController.h
//  project2
//
//  Created by Kara Yu on 3/23/12.
//  Copyright (c) 2012 EPIC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FlipsideViewController;
@class GoodGamePlay, EvilGamePlay;

@protocol FlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller;
@end

@interface FlipsideViewController : UIViewController

@property (weak, nonatomic) id <FlipsideViewControllerDelegate> delegate;  
@property (nonatomic, retain) IBOutlet UILabel *numberOfGuessesLabel;
@property (nonatomic, retain) IBOutlet UILabel *numberOfLettersLabel;
@property IBOutlet UISlider *numberOfGuessesSlider;
@property IBOutlet UISlider *numberOfLettersSlider;
@property IBOutlet UISwitch *evilSwitch;

@property (assign, nonatomic) unsigned int numberOfGuesses;
@property (assign, nonatomic) unsigned int numberOfLetters;
@property BOOL isEvil;
@property (nonatomic, retain) EvilGamePlay* Evil;
@property (nonatomic, retain) GoodGamePlay* Good;

- (IBAction)slidersChanged:(id)sender;
- (IBAction)done:(id)sender;
- (void)show;
- (void)viewDidLoad;

@end
