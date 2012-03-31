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
@synthesize totalGuesses = _totalGuesses;
@synthesize usedLetters = _usedLetters;


//load the plist
- (void)loadDictionary
{    
    // load plist file into dictionary
    _words = [[NSMutableDictionary alloc] initWithContentsOfFile:
                                  [[NSBundle mainBundle] pathForResource:@"Small" ofType:@"plist"]];
}


//when the user sets the word length, sets the wordLength varialbe and changes words to include only words of this length
- (void) setWordLength:(int)wordLength {
    
    //NEED TO ALSO EXCLUDE WHEN THE WORD LENGTH IS TOO LONG
    if (wordLength > 0 ) {
        
        //set the private variation equal to the word length
        _wordLength = wordLength;
    
        //results array
        NSMutableDictionary *new_words;
    
        //for each word, if its length matches, then add it to the result array
        for (NSString *word in [_words valueForKey:@"Key"]) {
            if ([word length] == wordLength) {
                //[new_words setValue:word forKey:@"Key"];
                [new_words setObject:word forKey: @"Key"];
            }
        
        }

        _words = new_words;
    }
    else {
        NSLog(@"invalid number!");
    }
}

//called when the user inputs a letter and returns where we should tell the user the letter is
//if we should tell the user that the letter isn't in the word, returns 0
- (int) guessLetter: (NSString *) letter 
{
    //if there are more words that don't have the letter than do, say the letter isn't there [IS THIS RIGHT?]
    if ([_potentialWords count] < ([_words count] - [_potentialWords count])) {
        return 0;
    }
    else {
        //we have determined that it's better to tell the user that the letter is in the word than not
        
        _potentialWords = [self qualifiedLetters:letter withWords: _words];
        
        NSMutableDictionary *positionPopularity = [self words: _potentialWords ByPositionForLetter: letter];
        
        int bestPosition = 0; 
        NSNumber *mostWords = 0; 
        
        for (int i = 0; i < ([[positionPopularity allKeys] count]); i++) {
                        
           NSNumber *num = [NSNumber numberWithInt:i]; 
            
            //CHECK THAT THIS IS THE RIGHT ORDER
            if ([[positionPopularity valueForKey: [num description]] compare: mostWords] == NSOrderedAscending ) {
                bestPosition = i;
                mostWords = [positionPopularity valueForKey: [num description]];
                
            }
        }
        
        return bestPosition;

    }
    
}


//given a list of words that have the letter, returns a hash table of position-> (number of words with letter in that position) pairs
- (NSMutableDictionary *) words: (NSMutableArray *) words ByPositionForLetter: letter
{
    //start result dictionary
    NSMutableDictionary *words_count; 
    
    //for each word in the dictionary
    for (NSString *word in [words valueForKey:@"Key"]) {
        
        //if the word has the letter at position p, increment the value of potential_words at position p
        if ([word rangeOfString:letter].location != NSNotFound) {
            
            //get the location where the letter matches
            //NEED TO CHECK WHETHER THIS STARTS AT 0 OR 1 FOR THE FIRST LETTER!!
            NSNumber *position = [NSNumber numberWithInt: ([word rangeOfString:letter].location)];
            
            //creates new_value which is (value at position)+1  
            NSNumber *new_value = [NSNumber numberWithInt: [[words_count objectForKey: position] intValue] + 1];
            
            //increment value in hashtable at key: letter position 
            [words_count setObject:new_value forKey: position];
            
        } else {
            NSLog(@"no match between letter and word!!");
        }
    }
    
    return words_count;

    
}

//returns array of words that work with the letter (given the starting word list)
- (NSMutableArray *) qualifiedLetters: (NSString *) letter withWords: words
{
    NSMutableArray *potential_words;
    
    //for each word in the dictionary
    for (NSString *word in [words valueForKey:@"Key"]) {
        if ([word rangeOfString:letter].location != NSNotFound) {
            [potential_words addObject: word];
        }
    }
    
    return potential_words;
        
}






@end
