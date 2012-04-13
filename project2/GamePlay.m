//
//  GamePlay.m
//  project2
//
//  Created by Kara Yu on 4/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GamePlay.h"

@implementation GamePlay

//dictionary file name
NSString *FileName = @"small";
@synthesize words, wordLength, minWordLength, maxWordLength, usedLetters;

- (id) init
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
        self.usedLetters = [[NSMutableArray alloc] init];
    }
    return self;
}


//load the plist
- (void) loadDictionary
{    
    // load plist file into dictionary
    self.words = [[NSMutableArray alloc] initWithContentsOfFile:
                  [[NSBundle mainBundle] pathForResource:FileName ofType:@"plist"]];
}


//figures out the length of the longest word in the current dictionary and sets the self.maxWordLength equal to that
- (BOOL) setMaxWordLength
{
    //initialize a temp variable
    int maxLength = 0;
    
    if ([self.words count] > 0) 
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
    //initialize minLength to a large number before iterating through the dictionary to find smaller word lengths
    int minLength = 200;
    
    if ([self.words count]>0) 
    {
        //iterates through all words and whenever the length is less than minLength, we update minLength to match
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
    //if self.usedLetters doesn't contain letter, then the guess is good to go!
    if ([self.usedLetters indexOfObject: letter] == NSNotFound) {
        return YES;
    }
    else {
        return NO;
    }
    
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
        foundRange = [string rangeOfString:letter options:0 range:searchRange];
        
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
    else 
    {
        //if there are no occurences, return the string "nonexistent"
        result = @"nonexistent";
    }
    
    return result;
}


@end


