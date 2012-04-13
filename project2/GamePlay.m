//
//  GamePlay.m
//  project2
//
//  Created by Kara Yu on 4/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GamePlay.h"

@implementation GamePlay


//current word list
@synthesize words = _words;


//word list given new letter from user
@synthesize wordLength = _wordLength;
@synthesize maxWordLength =_maxWordLength;
@synthesize minWordLength =_minWordLength;
@synthesize usedLetters = _usedLetters;

@synthesize maxHighScores = _maxHighScores;
@synthesize highScores = _highScores;


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
        
        //initializes the _usedLetters
        _usedLetters = [[NSMutableArray alloc] init];
    }
    return self;
}



@end


