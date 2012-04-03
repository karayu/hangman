//
//  MainViewController.h
//  project2
//
//  Created by Kara Yu on 3/23/12.
//  Copyright (c) 2012 EPIC. All rights reserved.
//

#import "FlipsideViewController.h"

@class GoodGamePlay, EvilGamePlay;

@interface MainViewController : UIViewController <FlipsideViewControllerDelegate>

//models
@property (nonatomic, retain) EvilGamePlay* Evil;
@property (nonatomic, retain) GoodGamePlay* Good;

//UI widgets
@property (nonatomic, weak) IBOutlet UILabel *remainingLettersLabel;
@property (nonatomic, weak) IBOutlet UILabel *numberOfGuessesLabel;
@property IBOutlet UITableView *highScoresTable;
@property IBOutlet UIButton *backButton;
@property (nonatomic, weak) IBOutlet UITextField *submitLetter;
@property (nonatomic, weak) IBOutlet UILabel *dummyResponse;

//variables
@property (assign, nonatomic) unsigned int numberOfGuesses;
@property (assign, nonatomic) unsigned int numberOfLetters;
@property unsigned char guessedLetter;
@property BOOL isEvil;
@property NSMutableString *alphabetString;
@property NSMutableArray *partialWord;
@property NSMutableArray *highScoresArray;

//UI methods
- (IBAction)viewHighScores:(id)sender;
- (IBAction)startNewGame:(id)sender;
- (IBAction)showInfo:(id)sender;

//all other methods
- (void)checkEndGame;
- (void)createNewGameView;
- (void)guessLetter;
- (void)updateAlphabet;
- (void)updateGuesses;
- (void)viewDidLoad;
- (void)textFieldShouldReturn:(UITextField *)textField;
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller;

@end