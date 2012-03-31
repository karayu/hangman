//
//  WordList.m
//  project2
//
//  Created by Kara Yu on 3/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WordList.h"

@implementation WordList

@synthesize words = _words;
@synthesize potential_words = _potential_words;

@synthesize evil = _evil;
@synthesize remaining_guesses = _remaining_guesses;
@synthesize word_length = _word_length;
@synthesize total_guesses = _total_guesses;
@synthesize used_letters = _used_letters;


//load the plist
- (void)loadDictionary
{    
    // load plist file into dictionary
    _words = [[NSMutableDictionary alloc] initWithContentsOfFile:
                                  [[NSBundle mainBundle] pathForResource:@"Small" ofType:@"plist"]];
}

//called when the user inputs a letter
- (void) guessLetter: (NSString *) letter 
{
    _potential_words = [self qualifiedWords: letter];
    int best_position = 0;
    int most_words = 0;
    
    for (int i = 0; i < _word_length; i++) {
       // if (most_words< [ _potential_words objectForKey: [NSNumber numberWithInt: i]].length ) {
            
       // }
            
    }
    
}


- (NSMutableDictionary *) words: (NSMutableDictionary *) words ByPosition: (int) loc ForLetter: letter
{
    //for each word in the dictionary
    for (NSString *word in [words valueForKey:@"Key"]) {
        
        //if the word has the letter at position p, increment the value of potential_words at position p
        if ([word rangeOfString:letter].location != NSNotFound) {
            
            //get the location where the letter matches
            //and save to the results hash table using the location as the key
            NSNumber *position = [NSNumber numberWithInt: ([word rangeOfString:letter].location)];
            
            //creates new_value which is (value at position)+1  
            NSNumber new_value = [NSNumber numberWithInt: [[word objectForKey: position] intValue] + 1];
            
            //increment value in hashtable at key: letter position 
            [potential_words setObject:new_value forKey: position];
            
        } else {
            NSLog(@"no match between letter and word!!");
        }
    }
    
}

//returns dictionary of words that work with the letter
- (NSMutableDictionary *) qualifiedWords: (NSString *) letter
{

    // start result dictionary
    NSMutableDictionary *potential_words; 
    

    
    return potential_words;
        
}






@end
