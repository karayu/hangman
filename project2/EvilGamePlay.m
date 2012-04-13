//
//  WordList.m
//  project2
//
//  Created by Kara Yu on 3/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "EvilGamePlay.h"

@implementation EvilGamePlay


//calculates the score based on word's length, number of words of the same length in the dictionary, and percent of guesses that were correct
- (int) calculateScore
{
    float percentAccuracy =  (float)self.wordLength /  (float)self.usedLetters.count;
    
    //beef up the score with a constant multiplier (multiplied by a much bigger constant than Good for playing EVIL!)
    return percentAccuracy*(self.wordLength)*5500;
}


/*checks to see if the game has been won by 
 1) seeing if the number of words left is 1
 2) seeing if all the letters in the word have been guessed
 */
- (BOOL) checkGameWon 
{
    //IF ONLY ONE WORD IS LEFT YOU HAVE WON! (if you've guessed all the letters)
    if ([self.words count] == 1) {
        
        //gets the last word left in the "words" array
        NSString *word = [self.words objectAtIndex:0];
        
        //for each letter in the word   
        for (int i=0; i< [word length]; i++) 
        {
            //get the letter
            NSString* letter = [word substringWithRange:NSMakeRange(i,1)];
            
            //if the letter isn't in our used letters, return false                        
            if ([self.usedLetters indexOfObject:letter ] == NSNotFound) 
            {
                return NO;
            }
        }
        //if all characters in string have been guessed, return true
        return YES;
    }
    //if there is more than one word left, return false
    return NO;
}


/*
 1) called when the user inputs a letter and returns where we should tell the user the letter is
 2) returns an array of all letter positions.  
 3) if the letter isn't there, returns an array with nonexistent as the first element
 4) updates self.words to include only words with letter in the given position (or words without the letter if that is the case)
 */
- (NSArray *) guessLetter: (NSString *) letter 
{
    
    //converts the input to uppercase because our dictionary is uppercase
    letter = [letter uppercaseString];
    
    //create the dictionary
    NSMutableDictionary *equivHash=[self words:self.words ByPositionForLetter:letter];
    
    //the positions where the letter should appear
    NSString *bestPosition;
        
    //number of words in equivalence class for that position
    int mostWords = 0;
    
    for (id key in equivHash) 
    {
        //value = list of words that have the same equivalence class
        id value = [equivHash objectForKey:key];
        
        //if the number of words at position "num" is greater than our current max
        if ([value count] > mostWords ) 
        {
            //update bestposition to be our current positions 
            bestPosition = key;
            
            //update the number of words to be the # of words with that key
            mostWords = [value count];
        }
    }
    
    //adds the letter to used letters list
    [self.usedLetters addObject:letter];
    
    //converts the key of letter positions into an array
    NSArray *positions = [bestPosition componentsSeparatedByString: @"-"];
    
    //sets the words to the set of of words with the most common equivalence class
    self.words = [equivHash objectForKey:bestPosition];

    return positions;
}


//if user loses , return a random word from the remaining set of words
- (NSString *) losingWord
{
    //r is a random number ranging from 0 to number of words in dictionary
    int r = arc4random() % [self.words count]; 
    return [self.words objectAtIndex:r];
}


//returns a hashtable of equivalence class name->array of words that match that equivalence class
- (NSMutableDictionary *) words: (NSMutableArray *) wordList ByPositionForLetter: letter
{
    //start result dictionary
    NSMutableDictionary *wordsByPosition = [[NSMutableDictionary alloc] init];
    
    //for each word in the dictionary
    for (NSString *word in wordList) {
        
        //get the equivalence class for the word 
        NSString *occ = [self occurenceLocations:letter InWord:word];
        
        //temp variable holding all words of this equivalence class
        NSMutableArray *curr =[[NSMutableArray alloc] init];   
        [curr removeAllObjects];
        
        //put in all the words that were in this equivalenc class before this word
        [curr addObjectsFromArray: [wordsByPosition objectForKey:occ]];
        
        //add the new word to the array of words with the same equivalence class
        if (curr != NULL) {
            [curr addObject: word];
        }
        else {
            curr = [NSMutableArray arrayWithObjects: word, nil];
        }
        
        //set our current array as the official array     
        [wordsByPosition setObject:curr forKey:occ];
    }
    
    return wordsByPosition;
}



@end
