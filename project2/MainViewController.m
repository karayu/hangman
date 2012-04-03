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

@synthesize remainingLettersLabel, numberOfLetters, numberOfGuesses, numberOfGuessesLabel, submitLetter, letter, dummyResponse, highScoresTable, alphabetString, partialWord, highScoresArray, backButton;

//turns on/off "hidden" value for high scores table
- (IBAction)viewHighScores:(id)sender
{    
    //ANIMATED WOOOO!
    CATransition *animation = [CATransition animation];
    
    //if the high scores table is hidden, unhide it when "High Scores" button is clicked
    if (highScoresTable.hidden == YES) 
    {
        animation.type = kCATransitionMoveIn;
        [highScoresTable.layer addAnimation:animation forKey:nil];
        
        //unhide high scores table and "Back" button
        highScoresTable.hidden = NO;
        backButton.hidden = NO;
    }
    //if it's not hidden, hide table & button when "Back" button is clicked
    else 
    {
        animation.type = kCATransitionPush;
        [highScoresTable.layer addAnimation:animation forKey:nil];
        
        //hide high scores table and back button
        highScoresTable.hidden = YES;
        backButton.hidden = YES;
    }
}

//feeds user an alert when she clicks "New Game"
- (IBAction)startNewGame:(id)sender
{
    //if user agrees "Yes" to starting a new game, the view will be re-loaded
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"You sure you want a new game?" 
                                                        message:@"(You will lose your current game)" 
                                                       delegate:self 
                                              cancelButtonTitle:@"NOOOO" 
                                              otherButtonTitles:@"Yes I am sure", nil];
    [alertView show];
}

//if user clicks "Yes" on alert popup to start New Game, refresh the view (& thus start new game)
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) 
    {
        [self viewDidLoad];
    }
}

//checks to see if number of guesses remaining is at zero; if so, user has lost and starts new game
- (void)checkEndGame
{
    //send user an alert if she is out of guesses
    if (self.numberOfGuesses == 0) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"OH NO!" 
                                                            message:@"You lose!  Joseph is dead!" 
                                                           delegate:self 
                                                  cancelButtonTitle:@"New Game" 
                                                  otherButtonTitles:nil];
        [alertView show];
        
        //refresh the view, initializing new settings and thus starting new game
        [self viewDidLoad];
    }
}

//handles guessing of each letter
- (void)guessLetter
{
    //decrement # of guesses if letter is incorrect, i.e. this would not usually be here
    self.numberOfGuesses--;
    [self updateGuesses];

    if (5 == 0)
    {
        //decrement guesses here
    }
    else 
    {
        //insert letter at index
        int index = 2;
        index = index - 1;
        
        NSString *newLetter = [NSString stringWithFormat:@"%c", self.letter];
        [self.partialWord replaceObjectAtIndex:index withObject:newLetter];
    }
    
    NSString *joinedString = [self.partialWord componentsJoinedByString:@"  "];
    self.dummyResponse.text = joinedString;
}

//initializes the alphabet with the start of each new game
- (void)createAlphabet
{
    alphabetString = [NSMutableString stringWithCapacity: 26];
    
    //create alphabet
    for(char c = 'A'; c <= 'Z'; c++)
    {
        [alphabetString appendFormat: @"%c", c];
    }
    //print alphabet to remainingLettersLabel
    self.remainingLettersLabel.text = alphabetString;  
}

- (void)updateAlphabet
{
    //check to see how many letters are left and what letter was just used  
    int length = [self.remainingLettersLabel.text length];
    alphabetString = [NSMutableString stringWithCapacity: 26];
    self.letter = [self.submitLetter.text characterAtIndex:0];
    
    //iterate through alphabet and remove letter that was just used
    for(int index = 0; index < length; index++) 
    {
        unichar character = [self.remainingLettersLabel.text characterAtIndex:index];
        if (character == self.letter)
            [alphabetString appendString:@"  "];
        else
            [alphabetString appendFormat: @"%c", character];
    }
    
    //print out new alphabet
    self.remainingLettersLabel.text = alphabetString;  
}

//updates the number of guesses label with the current # of guesses remaining
- (void)updateGuesses
{
    self.numberOfGuessesLabel.text = [NSString stringWithFormat:@" %d", self.numberOfGuesses];
}

//actions to perform with each reloading of the view (i.e. for every new game)
- (void)viewDidLoad
{
    //display number of guesses from user's settings
    self.numberOfGuesses = [[NSUserDefaults standardUserDefaults] integerForKey:@"numberOfGuesses"];        
    [self updateGuesses];
    
    //set number of guesses to default user's settings
    self.numberOfLetters = [[NSUserDefaults standardUserDefaults] integerForKey:@"numberOfLetters"];        
    
    //create a new alphabet with each new game
    [self createAlphabet];
    
    //load underscores to represent un-guessed word
    self.partialWord = [NSMutableArray arrayWithCapacity:self.numberOfLetters];
    for (int index = 1; index <= self.numberOfLetters; index++)
    {
        [self.partialWord addObject: @"_"];
    }
    NSString *joinedString = [self.partialWord componentsJoinedByString:@"  "];
    self.dummyResponse.text = joinedString;
}

//actions performed when user submits a letter as a guess
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{    
    //get letter
    self.letter = [self.submitLetter.text characterAtIndex:0];
    
    //retrieve word list and print dummy response to simulate some sort of gameplay
    [self guessLetter];
    
    //update the alphabet
    [self updateAlphabet];
    
    //hide keyboard
    [self.submitLetter resignFirstResponder];
    
    //check to see if user has lost game
    [self checkEndGame];
    
    return YES;
}

//allows only one character in the submitLetter textField
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    //if there is already a character in the textField, don't allow anymore to be typed
    if (range.location >= 1)
        return NO;
    
    //if got to this point, there are 0 characters in textField so we allow one to be typed
    return YES;
}

//setup High Scores table by calculating the number of rows
//source:http://stackoverflow.com/questions/5365107/fill-tableview-with-mutable-array
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
    //dummy placeholder array to fill High Scores for now
    self.highScoresArray = [NSMutableArray arrayWithObjects:@"COMPUTER - 1100 pts", @"SCIENCE - 1000 pts", @"CATS - 900 pts", nil];
    return self.highScoresArray.count;
}


//setup rows in High Scores table to display the array text
//source:http://stackoverflow.com/questions/5365107/fill-tableview-with-mutable-array
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = [self.highScoresArray objectAtIndex:indexPath.row];
    return cell;
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