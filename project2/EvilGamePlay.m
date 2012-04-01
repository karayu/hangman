//
//  WordList.m
//  project2
//
//  Created by Kara Yu on 3/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "EvilGamePlay.h"

@implementation EvilGamePlay

//current word list
@synthesize words = _words;


//word list given new letter from user
@synthesize potentialWords = _potentialWords;
        
@synthesize evil = _evil;
@synthesize remainingGuesses = _remainingGuesses;
@synthesize wordLength = _wordLength;
@synthesize maxWordLength =_maxWordLength;

@synthesize usedLetters = _usedLetters;


//figures out the length of the longest word in the current dictionary and sets the _maxWordLength equal to that
- (void) setMaxWordLength
{
    int maxLength = 0;
    
    //iterates through all words and if the length is greater than maxLength, we update maxLength to match
    for (NSString *word in _words) {
        if ( [word length] > maxLength) {
            maxLength = [word length];
        }
    }
    
    //sets _maxWordLength equal to length of longest word in this dictionary 
    _maxWordLength = maxLength;

}

//when the user sets the word length, sets the wordLength variable and changes words to include only words of this length
- (void) setWordLength:(int)wordLength {
    
    //NEED TO ALSO EXCLUDE WHEN THE WORD LENGTH IS TOO LONG
    if (wordLength > 0 && wordLength <= _maxWordLength ) {
        
        //set the private variation equal to the word length
        _wordLength = wordLength;
        
        //results array
        NSMutableArray *new_words = [[NSMutableArray alloc] init];
        
        //for each word, if its length matches, then add it to the result array
        for (NSString *word in _words) {
            if ([word length] == wordLength) {
                [new_words addObject:word];
            }
        }
        
        _words = new_words;
    }
    else {
        NSLog(@"invalid number!");
    }
}


//load the plist
- (void)loadDictionary
{    
    // load plist file into dictionary
    _words = [[NSMutableArray alloc] initWithContentsOfFile:
                                  [[NSBundle mainBundle] pathForResource:@"Small" ofType:@"plist"]];
}


//NEED TO TEST if this works
//figures out whether this letter has already been guessed before
- (BOOL) letterValid: (NSString *) letter 
{
    //if _usedLetters doesn't contain letter
    if ([_usedLetters indexOfObject: letter] == NSNotFound) {
        return true;
    }
    else {
        return false;
    }

}

//called when the user inputs a letter and returns where we should tell the user the letter is
//if we should tell the user that the letter isn't in the word, returns 0
- (int) guessLetter: (NSString *) letter 
{
    
    //converts the input to uppercase because our dictionary is uppercase
    letter = [letter uppercaseString];
    
    //figure out the words that have the letter in it
    _potentialWords = [self qualifiedLetters:letter withWords: _words];

    //if there are more words that don't have the letter than do, say the letter isn't there [IS THIS RIGHT?]
    if ([_potentialWords count] < ([_words count] - [_potentialWords count])) {
        
        //decreases the guesses left because you guessed wrong
        _remainingGuesses--;
        //adds letter to used letters list
        [_usedLetters addObject:letter]; 
        return 0;
    }
    else {
        //we have determined that it's better to tell the user that the letter is in the word than not
        
        //NSMutableDictionary *positionPopularity = [[NSMutableDictionary alloc] init];

        //hashtable of # of words with letter in each position
        NSMutableDictionary *positionPopularity = [self words: _potentialWords ByPositionForLetter: letter];
        
        //the position with the most words
        int bestPosition = 0; 
        
        //the number of words in the position with the most words
        NSNumber *mostWords = 0; 
        
        for (int i = 0; i < ([positionPopularity count]); i++) {
                        
           NSNumber *num = [NSNumber numberWithInt:i]; 
            
            //if the number of words at position "num" is greater than our current max
            if ([[positionPopularity valueForKey: [num description]] compare: mostWords] == NSOrderedDescending ) {
                
                //update bestposition to be our current position 
                bestPosition = i;
                
                //update the most # of words to the # of words at that position
                mostWords = [positionPopularity valueForKey: [num description]];
                
            }
        }
        
        //adds the letter to used letters list
        [_usedLetters addObject:letter]; 

        //updates the dictionary to be only words with the guessed letter in the right position
        _potentialWords = [self words: _potentialWords WithLetter:letter InPosition:bestPosition];
        _words = _potentialWords;
        
        //returns the position where the letter should be
        return bestPosition;

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


//returns a set of words out of potentialWords which have letter in the right position
- (NSMutableArray *) words: potentialWords WithLetter: (NSString *) letter InPosition: (int) position
{
    NSMutableArray *newWords = [[NSMutableArray alloc] init];
    
    //iterates through all the potential words
    NSEnumerator *enumerator = [potentialWords keyEnumerator];
    id word;
    while (word = [enumerator nextObject]) {        
        //for each word in potentialWords, if the word has letter in position, add it to the new words
        if ([word rangeOfString:letter].location == position ) {
            [newWords addObject:word];  
        }
    }
    
    return newWords;
    
}


//given a list of words that have the letter, returns a hash table of position-> (number of words with letter in that position) pairs
- (NSMutableDictionary *) words: (NSMutableArray *) words ByPositionForLetter: letter
{
    //start result dictionary
    NSMutableDictionary *wordsCount = [[NSMutableDictionary alloc] init];
    
    //for each word in the dictionary
    for (NSString *word in words) {
        
        //if the word has the letter at position p, increment the value of potential_words at position p
        if ([word rangeOfString:letter].location != NSNotFound) {
            
            //get the location where the letter matches.  We are starting at 1 for the first letter
            NSNumber *position = [NSNumber numberWithInt: ([word rangeOfString:letter].location)+1];
            
            //creates new_value which is (value at position)+1  
            NSNumber *new_value = [NSNumber numberWithInt: [[wordsCount objectForKey: position] intValue] + 1];
            
            //increment value in hashtable at key: letter position 
            [wordsCount setObject:new_value forKey: position];
            
        } else {
            NSLog(@"no match between letter and word!!");
        }
    }
    
    return wordsCount;

    
}

//returns array of words that work with the letter (given the starting word list)
- (NSMutableArray *) qualifiedLetters: (NSString *) letter withWords: words
{
    NSMutableArray *potentialWords = [[NSMutableArray alloc] init];

    
    //iterates through all the potential words
    NSEnumerator *enumerator = [words keyEnumerator];
    id word;
    
    while (word = [enumerator nextObject]) {        
        //for each word in potentialWords, if the word has the letter, add it to the new words
        if ([word rangeOfString:letter].location != NSNotFound ) {
            [potentialWords addObject:word];  
        }
    }
    
    return potentialWords;
        
}






@end
