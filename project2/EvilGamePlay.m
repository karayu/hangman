//
//  WordList.m
//  project2
//
//  Created by Kara Yu on 3/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "EvilGamePlay.h"

@interface EvilGamePlay ()

@end

@implementation EvilGamePlay

//current word list
@synthesize words = _words;

@synthesize wordLength = _wordLength;
@synthesize maxWordLength =_maxWordLength;
@synthesize minWordLength =_minWordLength;

@synthesize usedLetters = _usedLetters;


//initialize
-(id)init
{
    if (self = [super init])
    {
        // Initialization
        
        //loads dictionary
        [self loadDictionary];
        
        //determines max word length that user can specify
        [self setMaxWordLength];
        
        //sets word length for this round of play
        [self setWordLength];
        
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

//when the user sets the word length, sets the wordLength variable and changes words to include only words of this length
- (BOOL)setWordLength
{
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
        
        if([newWords count] > 0)
        {
            _words = newWords;
            return YES;
        }
    }
    return NO;
}


//load the plist
- (void)loadDictionary
{    
    // load plist file into dictionary
    _words = [[NSMutableArray alloc] initWithContentsOfFile:
                                  [[NSBundle mainBundle] pathForResource:@"words" ofType:@"plist"]];
}


//figures out whether this letter has already been guessed before
- (BOOL) letterValid: (NSString *) letter 
{
    //if _usedLetters doesn't contain letter
    if ([_usedLetters indexOfObject: letter] == NSNotFound) {
        return YES;
    }
    else {
        return NO;
    }

}

//called when the user inputs a letter and returns where we should tell the user the letter is
//returns an array of all letter positions.  If hangman should say that the letter isn't there, returns an array with nonexistent as the first element
//updates _words to include only words with letter in the best position or words without the letter
- (NSArray *) guessLetter: (NSString *) letter 
{
    
    //converts the input to uppercase because our dictionary is uppercase
    letter = [letter uppercaseString];
    
    NSMutableDictionary *equivHash=[self words:_words ByPositionForLetter:letter];
    
    
    //the positions where the letter should appear
    NSString *bestPosition;
    
    //NSMutableArray *potentialKeys = [[NSMutableArray alloc] init];
    
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
    [_usedLetters addObject:letter];
    
    NSArray *positions = [bestPosition componentsSeparatedByString: @"-"];
    
    if ([positions objectAtIndex: 0] == @"nonexistent") {
        //it is better to say the letter isn't in the word
        _words = [self words: _words WithoutLetter:letter ];    
        NSLog(@"current words: %@", _words);
    
    }
    else {
        //updates the dictionary to be only words with the guessed letter in the right positions
        _words = [self words: _words WithLetter:letter InPosition: bestPosition];
        NSLog(@"current words: %@", _words);

    }
    return positions;
}

/*checks to see if the game has been won by 
    1) seeing if the number of words left is 1
    2) seeing if all the letters in the word have been guessed
 */
- (BOOL) checkGameWon {
    if ([_words count] == 1) {
        
        NSString *word = [_words objectAtIndex:0];
        
        //for each letter in the word   
        for (int i=0; i< [word length]; i++) 
        {
            
            //get the letter
            NSString* letter = [word substringWithRange:NSMakeRange(i,1)];
            
            if ([_usedLetters indexOfObject:letter ] == NSNotFound) 
            {
                //if the letter isn't in our used letters, return false            
                return NO;
            }
        }
        //if all characters in string have been guessed, return true
        return YES;
    }
    //if there is more than one word left, return false
    return NO;
}

//calculates the score based on word's length, number of words of the same length in the dictionary, and percent of guesses that were correct, multiplied by TWO for playing EVIL! 
- (int64_t) calculateScore
{
    float percentAccuracy =  (float)_wordLength /  (float)[_usedLetters count];
    return percentAccuracy*_wordLength*[_words count];
}

//returns a set of words which have the letter in the right positions
- (NSMutableArray *) words: potentialWords WithLetter: (NSString *) letter InPosition: (NSString *) position
{
    NSMutableArray *newWords = [[NSMutableArray alloc] init];
    
    //iterates through all the potential words 
    for (NSString *word in potentialWords) {    
        //for each word in potentialWords, if the word has letter in position, add it to the new words
        if ( [[self occurenceLocations: letter InWord:word] isEqualToString: position]) 
        {
            [newWords addObject:word];  
        }
    }
    
    return newWords;
    
}


//returns a hashtable of equivalence class name->array of words that match that equivalence class
- (NSMutableDictionary *) words: (NSMutableArray *) words ByPositionForLetter: letter
{
    //start result dictionary
    NSMutableDictionary *wordsByPosition = [[NSMutableDictionary alloc] init];
    
    
    //for each word in the dictionary
    for (NSString *word in words) {
        
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

- (NSMutableArray *) words: words WithoutLetter: (NSString *)letter
{
    NSMutableArray *potentialWords = [[NSMutableArray alloc] init];
    
    //iterates through all the potential words
    for (NSString *word in _words ) {
        
        //for each word in potentialWords, if the word has the letter, add it to the new words
        if ([word rangeOfString:letter].location == NSNotFound ) {
            [potentialWords addObject:word];  
        }
    }
    
    return potentialWords;
}



@end
