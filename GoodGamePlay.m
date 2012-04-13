//
//  GoodGamePlay.m
//  project2
//
//  Created by Kara Yu on 4/2/12.
//  Copyright (c) 2012 EPIC. All rights reserved.
//

#import "GoodGamePlay.h"

@implementation GoodGamePlay

@synthesize word;


//initialization for good game play
- (id)init
{
    if (self = [super init])
    {        
        //automatically picks a word since "Good" gameplay chooses a word from the beginning
        [self pickWord];
    }
    return self;
}


//picks a random word of correct word length at the beginning of each new game
- (BOOL)pickWord
{
    if ([self.words count] > 0) 
    {
        //r is a random number ranging from 0 to number of words in dictionary
        int r = arc4random() % [self.words count]; 
        self.word = [self.words objectAtIndex:r];
        return YES;
    }
    //return false if there are 0 words :(
    else {
        return NO;
    }
}


//calculates the score based on word's length, number of words of the same length in the dictionary, and percent of guesses that were correct
- (int)calculateScore
{
    float percentAccuracy =  (float)self.wordLength /  (float)[self.usedLetters count];
    
    //multiply this result by a larger factor to juice up the scores! Evil game play has a larger factor than Good.
    return percentAccuracy*self.wordLength*1500;
}


//checks to see if game has been won by seeing if all chars in the word have been guessed
- (BOOL)checkGameWon
{        
    //for each letter in the word   
    for (int i=0; i< [self.word length]; i++) 
    {
        //get the letter
        NSString* letter = [self.word substringWithRange:NSMakeRange(i,1)];
        
        //if the letter isn't in our usedletters, return false            
        if ([self.usedLetters indexOfObject:letter ] == NSNotFound) 
        {
            return NO;
        }
    }
    
    //if all characters in string have been guessed, return true
    return YES;
}


//returns the location of the letter +1 (because it returns 0 if the letter isn't in the word)
- (NSArray *)guessLetter: (NSString *) letter 
{
    //add the letter to the list of used letters
    [self.usedLetters addObject:letter];
    
    //setup string for all the positions in which a letter exists in a given word
    NSString *positions = [self occurenceLocations:letter InWord:self.word];
    
    //create and return an array of the positions
    NSArray *positions_arr = [positions componentsSeparatedByString: @"-"];
    
    return positions_arr;
}


@end