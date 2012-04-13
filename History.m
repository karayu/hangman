//
//  History.m
//  project2
//
//  Created by Kara Yu on 4/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "History.h"


@interface History ()

@end

@implementation History

@synthesize highScoresArray = _highScoresArray;

//global constants
int MaxHighScores = 9;
NSString *HighScoreFileName = @"Scores";


- (id)init
{
    // Initialization
    if (self = [super init])
    {        
        //loads dictionary
        [self loadScores];
        
    }
    return self;
}


//load the plist
- (void) loadScores
{    
    // load plist file into dictionary
    self.highScoresArray = [[NSMutableArray alloc] initWithContentsOfFile:
                  [[NSBundle mainBundle] pathForResource:HighScoreFileName ofType:@"plist"]];
}

- (void) saveScores
{
    [self.highScoresArray writeToFile: [HighScoreFileName stringByAppendingString: @"plist"] atomically:YES];

}


//Depending on how high the score is, adds the high score to the high scores table, in the right position
- (BOOL) addHighScore: (int) score
{
NSNumber *newScore = [[NSNumber alloc] init];
newScore = [NSNumber numberWithInt:score];

//add score to the high scores array
[self.highScoresArray addObject:newScore];

//sort the high scores array
//sort descending - http://stackoverflow.com/questions/3749657/nsmutablearray-arraywitharray-vs-initwitharray
NSSortDescriptor* sortOrder = [NSSortDescriptor sortDescriptorWithKey: @"self" ascending: NO];
NSArray *sorted = [self.highScoresArray sortedArrayUsingDescriptors: [NSArray arrayWithObject: sortOrder]];

self.highScoresArray = [[NSMutableArray alloc] initWithArray:sorted];


//if we have too many scores, delete the smallest one
if ((int)[self.highScoresArray count] > MaxHighScores ) 
{
    [self.highScoresArray removeLastObject];
    NSLog(@"high scores are: %@", self.highScoresArray);
    
}

return YES;
}

@end