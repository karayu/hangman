//
//  GoodGamePlay.m
//  project2
//
//  Created by Kara Yu on 4/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GoodGamePlay.h"

@implementation GoodGamePlay

@synthesize word = _word;
@synthesize words = _words;

@synthesize wordLength = _wordLength;
@synthesize maxWordLength = _maxWordLength;
@synthesize minWordLength = _minWordLength;


@synthesize usedLetters = _usedLetters;

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
        
        //automatically picks a word since "Good" gameplay chooses a word from the beginning
        [self pickWord];
        
        //initializes the _usedLetters
        _usedLetters = [[NSMutableArray alloc] init];
    }
    return self;
}

//figures out the length of the longest word in the current dictionary and sets the _maxWordLength equal to that
- (BOOL) setMaxWordLength
{
    int maxLength = 0;
    
    if ([_words count]>0) 
    {
        //iterates through all words and if the length is greater than maxLength, we update maxLength to match
        for (NSString *word in _words) 
        {
            if ( [word length] > maxLength) 
            {
                maxLength = [word length];
            }
        }
    
        //sets _maxWordLength equal to length of longest word in this dictionary 
        _maxWordLength = maxLength;
        return YES;
    }
    else {
        return NO;
    }
}

//figures out the length of the longest word in the current dictionary and sets the _maxWordLength equal to that
- (BOOL) setMinWordLength
{
    int minLength = 200;
    
    if ([_words count]>0) 
    {
        //iterates through all words and if the length is greater than maxLength, we update maxLength to match
        for (NSString *word in _words) 
        {
            if ( [word length] < minLength) 
            {
                minLength = [word length];
            }
        }
        
        //sets _maxWordLength equal to length of longest word in this dictionary 
        _minWordLength = minLength;
        return YES;
    }
    else {
        return NO;
    }
    
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


//when the user sets the word length, sets the wordLength variable and changes words to include only words of this length
- (BOOL) setWordLength
{
    //get user's default word length
    int wordLength = [[NSUserDefaults standardUserDefaults] integerForKey:@"numberOfLetters"];
    
    //NEED TO ALSO EXCLUDE WHEN THE WORD LENGTH IS TOO LONG
    if (wordLength > 0 && wordLength <= _maxWordLength ) 
    {
        
        //set the private variation equal to the word length
        _wordLength = wordLength;
        
        //results array
        NSMutableArray *newWords = [[NSMutableArray alloc] init];
        
        //for each word, if its length matches, then add it to the result array
        for (NSString *word in _words) 
        {
            if ([word length] == wordLength) 
            {
                [newWords addObject:word];
            }
        }
        
        //make sure newWords actually contains something, and if so assign this to "words" and return true
        if([newWords count] > 0)
        {
            _words = newWords;
            return YES;
        }
    }
    //if newWords is empty, user has chosen a word length that does has no words in this dictionary
    return NO;
}


//load the plist
- (void)loadDictionary
{    
    // load plist file into dictionary
    _words = [[NSMutableArray alloc] initWithContentsOfFile:
              [[NSBundle mainBundle] pathForResource:@"words" ofType:@"plist"]];
}

//picks a random word of correct word length for Good Game Play
- (BOOL) pickWord
{
    if ([_words count] >0) 
    {
        //r is a random number ranging from 0 to number of words in dictionary
        int r = arc4random() % [_words count]; 
        _word = [_words objectAtIndex:r];
        return YES;
        
    }
    else {
        return NO;
    }
}


//returns the location of the letter +1
//returns 0 if the letter isn't in the word
- (NSArray *) guessLetter: (NSString *) letter 
{
    //add the letter to the list of used letters
    [_usedLetters addObject:letter];
    
    //setup string for all the positions in which a letter exists in a given word
    NSString *positions = [self occurenceLocations:letter InWord:_word];
    
    //create and return an array of the positions
    NSArray *positions_arr = [positions componentsSeparatedByString: @"-"];

    return positions_arr;
}

//returns a string with locations of occurence(s)
//source: http://stackoverflow.com/questions/7033574/find-all-locations-of-substring-in-nsstring-not-just-first
- (NSString *) occurenceLocations: (NSString *) letter InWord: (NSString *) string
{
    //empty array for occurrences of letter
    NSMutableArray *occ = [[NSMutableArray alloc] init];
    
    //search range is the entire length of the string
    NSRange searchRange = NSMakeRange(0,string.length);
    NSRange foundRange;
    
    while (searchRange.location < string.length) {
        searchRange.length = string.length-searchRange.location;
        //store where we found the letter in the word
        foundRange = [string rangeOfString:letter options:nil range:searchRange];
        if (foundRange.location != NSNotFound) {
            // found an occurrence of the letter! add the location to the database
            [occ addObject: [NSNumber numberWithInt: foundRange.location]];
            
            //move ahead and continue
            searchRange.location = foundRange.location+foundRange.length;
        } else {
            // no more letters to find
            break;
        }
    }
    
    //if there are occurrence(s) of the string in word, piece them together into a string to make a good key
    NSString *result;
    if ([occ count] > 0) 
    {
        result = [occ componentsJoinedByString: @"-"];
    }
    else {
        
        //if there are no occurences, return the string "nonexistent"
        result = @"nonexistent";
    }
    
    return result;
    
}

//calculates the score based on word's length, number of words of the same length in the dictionary, and percent of guesses that were correct
- (int64_t) calculateScore
{
    float percentAccuracy =  (float)_wordLength /  (float)[_usedLetters count];
    return percentAccuracy*_wordLength*[_words count];
}

//checks to see if game has been won by seeing if all chars in the word have been guessed
- (BOOL) checkGameWon
{        
    //for each letter in the word   
    for (int i=0; i< [_word length]; i++) 
    {
        //get the letter
        NSString* letter = [_word substringWithRange:NSMakeRange(i,1)];
        
        if ([_usedLetters indexOfObject:letter ] == NSNotFound) 
        {
            //if the letter isn't in our usedletters, return false            
            return NO;
        }
    }
    
    //if all characters in string have been guessed, return true
    return YES;
    
}






@end