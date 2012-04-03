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


-(id)init
{
    if (self = [super init])
    {
        // Initialization
        
        //loads dictionary
        [self loadDictionary];
        
        //determines max word length that user can specify
        [self setMaxWordLength];
                
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
        return true;
    }
    else {
        return false;
    }
    
}

//when the user sets the word length, sets the wordLength variable and changes words to include only words of this length
- (BOOL) setWordLength: (int)wordLength 
{
    
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
        
        _words = newWords;
        return true;
    }
    else {
        
        NSLog(@"invalid number!");        
        return false;
    }
}


//load the plist
- (void)loadDictionary
{    
    // load plist file into dictionary
    _words = [[NSMutableArray alloc] initWithContentsOfFile:
              [[NSBundle mainBundle] pathForResource:@"Small" ofType:@"plist"]];
}

- (BOOL) pickWord
{
    if ([_words count] >0) 
    {
        //r is a random number ranging from 0 to number of words in dictionary
        int r = arc4random() % [_words count]; 
        _word = [_words objectAtIndex:r];
        return true;
        
    }
    else {
        return false;
    }
}


//returns the location of the letter +1
//returns 0 if the letter isn't in the word
- (int) guessLetter: (NSString *) letter 
{
    if ([_word rangeOfString:letter].location == NSNotFound ) 
    {
        return 0;
    }
    else {
        return [_word rangeOfString:letter].location +1;
    }

    
}

- (BOOL) checkGameWon {
    if ([_words count] == 1) {
        NSString *word = [_words objectAtIndex:0];
        
        for (NSInteger i=0; i<word.length; i++) {
            // if any characters in string have not been guessed, return false
            // TEST THIS!  indexOfObject:char work with an array of strings??
            //if ([_usedLetters indexOfObject: [word characterAtIndex:charIdx]] == NSNotFound) {
            //    return false;
            //}
        }
        
        //if all characters in string have been guessed, return true
        return true;
        
    }
    
    return false;
}






@end