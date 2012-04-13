//
//  MainViewController.m
//  project2
//
//  Created by Kara Yu on 3/23/12.
//  Copyright (c) 2012 EPIC. All rights reserved.
//

#import "MainViewController.h"
#import "HighScoresViewController.h"

#import "EvilGamePlay.h"
#import "GoodGamePlay.h"

@interface MainViewController ()

@end

@implementation MainViewController

@synthesize remainingLettersLabel, numberOfLetters, numberOfGuesses, numberOfGuessesLabel, submitLetter, guessedLetter, dummyResponse, highScoresTable, alphabetString, partialWord, highScoresArray, backButton, Evil, Good, isEvil, maxHighScores;

//Depending on how high the score is, adds the high score to the high scores table, in the right position
- (BOOL) addHighScore: (int) score
{
    NSNumber *newScore = [[NSNumber alloc] init];
    newScore = [NSNumber numberWithInt:score];

    //add score to the high scores array
    [self.highScoresArray addObject:newScore];

    //sort the high scores array
    //sort descending - http://stackoverflow.com/questions/3749657/nsmutablearray-arraywitharray-vs-initwitharray
    NSSortDescriptor* sortOrder = [NSSortDescriptor sortDescriptorWithKey: @"self" ascending: NO];
    NSArray *sorted = [self.highScoresArray sortedArrayUsingDescriptors: [NSArray arrayWithObject: sortOrder]];
    
    self.highScoresArray = [[NSMutableArray alloc] initWithArray:sorted];

    
    //if we have too many scores, delete the smallest one
    if ((int)[self.highScoresArray count] > (int)[self.maxHighScores intValue]) 
    {
        [self.highScoresArray removeLastObject];
        NSLog(@"high scores are: %@", self.highScoresArray);

    }
    
    return YES;
  }


//turns on/off "hidden" value for high scores table
- (IBAction)viewHighScores:(id)sender
{    
    
    HighScoresViewController *highScoresController = [[HighScoresViewController alloc] initWithNibName:@"HighScoresViewController" bundle:nil];
    
    highScoresController.maxHighScores = self.maxHighScores;
    highScoresController.highScoresArray = self.highScoresArray;
    
    highScoresController.delegate = (id)self;
    highScoresController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
    [self presentModalViewController:highScoresController animated:YES];
    
    /*
    //ANIMATED WOOOO!
    CATransition *animation = [CATransition animation];
    
    //if the high scores table is hidden, unhide it when "High Scores" button is clicked
    if (highScoresTable.hidden == YES) 
    {
        animation.type = kCATransitionMoveIn;
        [highScoresTable.layer addAnimation:animation forKey:nil];
        
        //show high scores table
        highScoresTable.hidden = NO;
        
        
        [self tableView:highScoresTable cellForRowAtIndexPath:[NSIndexPath indexPathWithIndex:0]];

        NSLog(@"high scores are: %@", self.highScoresArray);

        
        //show back button with SICK animation
        animation.type = kCATransitionFade;
        [backButton.layer addAnimation:animation forKey:nil];
        backButton.hidden = NO;
    }
    //hide table & button when "Back" button is clicked
    else 
    {
        animation.type = kCATransitionPush;
        [highScoresTable.layer addAnimation:animation forKey:nil];
        
        //hide high scores table since user is done viewing
        highScoresTable.hidden = YES;
        
        //hide back button with sick animation
        animation.type = kCATransitionFade;
        [backButton.layer addAnimation:animation forKey:nil];
        backButton.hidden = YES;
    }*/
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
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
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
    if (self.numberOfGuesses == 0) 
    {
        //declare the string word
        NSString *losingWord;
        
        //get losing word from Evil or Good
        if (isEvil)
           losingWord = [self.Evil losingWord];
        else
            losingWord = [self.Good word];
        
        //create losing message that gives user the word they were not smart enough to guess
        NSString *losingMessage = [NSString stringWithFormat:@"In case you were wondering, your word was %@", losingWord];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"YOU LOSE!" 
                                                            message:losingMessage
                                                           delegate:self 
                                                  cancelButtonTitle:@"New Game" 
                                                  otherButtonTitles:nil];
        [alertView show];
        
        //refresh the view, initializing new settings and thus starting new game
        [self viewDidLoad];
    }
    //if won, calculate EVIL score based on dictionary used, word length, and factor in extra EVIL points
    else if (isEvil && [self.Evil checkGameWon]) 
    {
        int score = [self.Evil calculateScore];
        
        [self addHighScore:score];
        
        NSString *text = [NSString stringWithFormat:@"Score: %d", score];
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"You win! Joseph Lives"
                                                            message:text
                                                           delegate:self 
                                                  cancelButtonTitle:@"New Game" 
                                                  otherButtonTitles:nil];
        [alertView show];
        
        //refresh the view, initializing new settings and thus starting new game
        [self viewDidLoad];        
    }
    //if won, calculate score based on dictionary, word length, and # of guesses
    else if (!isEvil && [self.Good checkGameWon])
    {        
        float score = [self.Good calculateScore];
        
        [self addHighScore:score];

        NSString *text = [NSString stringWithFormat:@"Score: %d", score];
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"You win! Joseph Lives"
                                                            message:text
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
    //cast letter to string and set up array for the letter's positions (if any) in the word
    NSString *letter = [NSString stringWithFormat:@"%c", self.guessedLetter];
    NSArray *letterPositions;
    
    if ((isEvil && ![self.Evil letterValid:letter]) || (!isEvil && ![self.Good letterValid:letter]))
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"HEY"
                                                            message:@"You already guessed that!"
                                                           delegate:self 
                                                  cancelButtonTitle:@"OK" 
                                                  otherButtonTitles:nil];
        [alertView show];
    }
    else 
    {
        //depending on whether isEvil or not, grabs the letter positions of this letter
        if (isEvil)
            letterPositions = [self.Evil guessLetter:letter];
        else
            letterPositions = [self.Good guessLetter:letter];
        
        //letterPositions returns "nonexistent" if the letter is not even in the word
        if ([letterPositions objectAtIndex:0]==@"nonexistent")
        {
            self.numberOfGuesses--;
            [self updateGuesses];
        }
        //otherwise, iterate through all places to print out the letter wherever it shows up
        else 
        {
            int count = [letterPositions count];
            for (int index=0; index < count; index++)
            {
                int position = [[letterPositions objectAtIndex:index] intValue];
                
                //update "partialWord" by replacing underscores with the letter
                [self.partialWord replaceObjectAtIndex:position withObject:letter];
            }
        }
        
        //update textfield with new partialWord
        self.dummyResponse.text = [self.partialWord componentsJoinedByString:@"  "];
    }
    
}

//renders the full alphabet with the start of each new game
- (void)createNewGameView
{
    alphabetString = [NSMutableString stringWithCapacity: 26];
    
    //render alphabet to represent unguessed letters
    for(char c = 'A'; c <= 'Z'; c++)
    {
        [alphabetString appendFormat: @"%c", c];
    }
    //print alphabet to remainingLettersLabel
    self.remainingLettersLabel.text = alphabetString;  

    //load underscores to visually represent un-guessed letters in a word
    self.partialWord = [NSMutableArray arrayWithCapacity:self.numberOfLetters];
    for (int index = 1; index <= self.numberOfLetters; index++)
    {
        [self.partialWord addObject: @"_"];
    }
    
    //join the blank underscores with spaces to show hangman-style blank word
    NSString *joinedString = [self.partialWord componentsJoinedByString:@"  "];
    self.dummyResponse.text = joinedString;
}

//refreshes the remaining letters with every guess
- (void)updateAlphabet
{
    //check to see how many letters are left and what letter was just used  
    int length = [self.remainingLettersLabel.text length];
    alphabetString = [NSMutableString stringWithCapacity: 26];
    
    //iterate through alphabet and remove letter that was just used
    for(int index = 0; index < length; index++) 
    {
        unichar character = [self.remainingLettersLabel.text characterAtIndex:index];
        if (character == self.guessedLetter)
            [alphabetString appendString:@"  "];
        else
            [alphabetString appendFormat: @"%c", character];
    }
    
    //print out new alphabet
    self.remainingLettersLabel.text = alphabetString;
}


//updates the number of guesses label with the current # of guesses remaining and change images
- (void)updateGuesses
{
    self.numberOfGuessesLabel.text = [NSString stringWithFormat:@" %d", self.numberOfGuesses];
    
    //change hangman image with each wrong guess
    self.imageNumber = self.imageNumber + self.imageIncrement;
    NSLog(@"%d", self.imageNumber);
    self.imageView.image = [imageArray objectAtIndex:self.imageNumber];
}

//actions to perform with each reloading of the view (i.e. for every new game)
- (void)viewDidLoad
{
    //initialize model based on Evil or not
    
    //sets the max number of high scores
    if (!self.maxHighScores) 
    {
        self.maxHighScores = [NSNumber numberWithInt: 2];
    }
    
    //initializes the set of all high scores
    if (!self.highScoresArray) 
    {
        self.highScoresArray = [[NSMutableArray alloc] init];
    }
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"evil"] == NO) 
    {
        self.Good = [[GoodGamePlay alloc] init];
        self.isEvil = NO;
    }
    else 
    {
        self.Evil = [[EvilGamePlay alloc] init];
        self.isEvil = YES;
        
        //give Evil the default value of "YES" in case this is the first time user has played
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"evil"];
    }
    
    //clear any input in textbox
    submitLetter.text = @"";
    
    //set number of guesses from user's settings
    if (!(self.numberOfGuesses = [[NSUserDefaults standardUserDefaults] integerForKey:@"numberOfGuesses"]))
    {
        //set a default number of guesses for first time playing
        self.numberOfGuesses = 7;
        [[NSUserDefaults standardUserDefaults] setInteger:self.numberOfGuesses forKey:@"numberOfGuesses"];
    }
    
    //load images for hangman
    self.imageArray = [NSMutableArray arrayWithCapacity:27];
    for (int i=0; i<27; i++)
    {
        NSString *imageName = [NSString stringWithFormat:@"%d.jpg", i];
        [self.imageArray addObject:[UIImage imageNamed:imageName]];
    }
    
    //initialize imageNumber to zero, display first image (empty hangman)
    self.imageNumber = 0;
    self.imageIncrement = 26/self.numberOfGuesses;
    self.imageView.image = [imageArray objectAtIndex:self.imageNumber];
    
    //display number of guesses
    self.numberOfGuessesLabel.text = [NSString stringWithFormat:@" %d", self.numberOfGuesses];

    //set number of letters to default user's settings
    if (!(self.numberOfLetters = [[NSUserDefaults standardUserDefaults] integerForKey:@"numberOfLetters"]))
    {
        //set a default number of letters for user's first time playing based on word lengths of dictionaries
        if (self.isEvil)
            self.numberOfLetters = [self.Evil minWordLength];
        else
            self.numberOfLetters = [self.Good minWordLength];
        
        //set this as default numberOfLetters until user changes their settings
        [[NSUserDefaults standardUserDefaults] setInteger:self.numberOfLetters forKey:@"numberOfLetters"];
    }        
    
    //render a new alphabet with each new game for user to see what letters they've used
    [self createNewGameView];
}

//actions performed when user submits a letter as a guess
- (void)textFieldShouldReturn:(UITextField *)textField
{    
    @try {
        //get letter
        self.guessedLetter = [self.submitLetter.text characterAtIndex:0];

        //retrieve word list and print dummy response to simulate some sort of gameplay
        [self guessLetter];
    
        //update the alphabet
        [self updateAlphabet];
        
        //hide keyboard
        [self.submitLetter resignFirstResponder];
    
        //check to see if user has lost game
        [self checkEndGame];
    }
    @catch (NSException * e) 
    {
        //complains to user to give input
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"You need to give us input" 
                                                            message:nil
                                                           delegate:self 
                                                  cancelButtonTitle:@"Okay!" 
                                                  otherButtonTitles:nil];
        [alertView show];
    }
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

#pragma mark - HighScore View

- (void)highScoresViewControllerDidFinish:(HighScoresViewController *)controller
{
    [self dismissModalViewControllerAnimated:YES];
}

#pragma mark - Flipside View

- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller
{
    [self dismissModalViewControllerAnimated:YES];
}

//flips to the Flipside view, sending "self" as delegate so we can get back to main controller
- (IBAction)showInfo:(id)sender
{    
    FlipsideViewController *controller = [[FlipsideViewController alloc] initWithNibName:@"FlipsideViewController" bundle:nil];
    controller.delegate = self;
    controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentModalViewController:controller animated:YES];
}

@end