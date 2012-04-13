//
//  GamePlay.m
//  project2
//
//  Created by Kara Yu on 4/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GamePlay.h"

@implementation GamePlay


//current word list
@synthesize words = _words;


//word list given new letter from user
@synthesize wordLength = _wordLength;
@synthesize maxWordLength =_maxWordLength;
@synthesize minWordLength =_minWordLength;
@synthesize usedLetters = _usedLetters;

@synthesize maxHighScores = _maxHighScores;
@synthesize highScores = _highScores;


- (id)init
{
    // Initialization
    if (self = [super init])
    {        
        //loads dictionary
        [self loadDictionary];
        
        //determines max word length that user can specify
        [self setMaxWordLength];
        
        //sets word length 
        [self setWordLength];
        
        //initializes the _usedLetters
        _usedLetters = [[NSMutableArray alloc] init];
    }
    return self;
}

//load the plist
- (void) loadDictionary
{    
    // load plist file into dictionary
    self.words = [[NSMutableArray alloc] initWithContentsOfFile:
                  [[NSBundle mainBundle] pathForResource:@"words" ofType:@"plist"]];
}

//figures out the length of the longest word in the current dictionary and sets the self.maxWordLength equal to that
- (BOOL) setMaxWordLength
{
    int maxLength = 0;
    
    if ([self.words count]>0) 
    {
        //iterates through all words and if the length is greater than maxLength, we update maxLength to match
        for (NSString *word in self.words) 
        {
            if ( [word length] > maxLength) 
            {
                maxLength = [word length];
            }
        }
        
        //sets self.maxWordLength equal to length of longest word in this dictionary 
        self.maxWordLength = maxLength;
        return YES;
    }
    else {
        return NO;
    }
    
}

//figures out the length of the shortest word in the current dictionary and sets the self.minWordLength equal to that
- (BOOL) setMinWordLength
{
    int minLength = 200;
    
    if ([self.words count]>0) 
    {
        //iterates through all words and if the length is greater than maxLength, we update maxLength to match
        for (NSString *word in self.words) 
        {
            if ( [word length] < minLength) 
            {
                minLength = [word length];
            }
        }
        
        //sets self.maxWordLength equal to length of longest word in this dictionary 
        self.minWordLength = minLength;
        return YES;
    }
    else {
        return NO;
    }
    
}

//when the user sets the word length, sets the wordLength variable and changes words to include only words of this length
- (BOOL)setWordLength
{
    //gets default word length from user
    int length = [[NSUserDefaults standardUserDefaults] integerForKey:@"numberOfLetters"];
    
    //makes sure that user gave us ok input
    if (length > 0 && length <= self.maxWordLength ) 
    {
        //set the private variation equal to the word length
        self.wordLength = length;
        
        //results array
        NSMutableArray *newWords = [[NSMutableArray alloc] init];
        
        //for each word, if its length matches, then add it to the result array
        for (NSString *word in self.words) 
        {
            if ([word length] == length) 
            {
                [newWords addObject:word];
            }
        }
        //if words exist in the dictionary of length "wordLength", save these in self.words and return true
        if([newWords count] > 0)
        {
            self.words = newWords;
            return YES;
        }
    }
    return NO;
}



//figures out whether this letter has already been guessed before
- (BOOL) letterValid: (NSString *) letter 
{
    //if self.usedLetters doesn't contain letter
    if ([self.usedLetters indexOfObject: letter] == NSNotFound) {
        return YES;
    }
    else {
        return NO;
    }
    
}



@end


