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
    _potential_words = [self qualified_words: letter];
    int best_position = 0;
    int most_words = 0;
    
    for (int i = 0; i < _word_length; i++) {
       // if (most_words< [ _potential_words objectForKey: [NSNumber numberWithInt: i]].length ) {
            
       // }
            
    }
    
}

//returns dictionary of words that work with the letter
- (NSMutableDictionary *) qualified_words: (NSString *) letter
{

    // start result dictionary
    NSMutableDictionary *potential_words; 
    
    //for each word in the dictionary
    for (NSString *word in [_words valueForKey:@"Key"]) {
        
        //if the work has the letter
        if ([word rangeOfString:letter].location != NSNotFound) {
            
            //get the location where the letter matches
            //and save to the results hash table using the location as the key
            int position = [word rangeOfString:letter].location;
       //     NSArray     
            
            [potential_words setObject:word forKey: [NSNumber numberWithInt: position]];
        
        } else {
            NSLog(@"no match between letter and word!!");
        }
    }
    
    return potential_words;
        
}






@end
