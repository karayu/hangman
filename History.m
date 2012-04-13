//
//  History.m
//  project2
//
//  Created by Kara Yu on 4/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "History.h"


@interface History ()

@property (nonatomic, strong) NSString *filePath;

@end

@implementation History

@synthesize highScoresArray = _highScoresArray;
@synthesize filePath = _filePath;

//global constants
int MaxHighScores = 15;
NSString *HighScoreFileName = @"scores";


- (id)init
{
    // Initialization
    if (self = [super init])
    {        
        //figures out where high scores list is kept
        if (! self.filePath)
        {
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *docDir = [paths objectAtIndex: 0];
            self.filePath = [docDir stringByAppendingPathComponent: HighScoreFileName];
        }
        
        //initializes high scores list
        if (! self.highScoresArray)
        {
            [self loadScores];
            
        }
        
    }
    return self;
}


//load the plist of high scores
- (void) loadScores
{    

    //sees if we can find the plist and load it
    self.highScoresArray = [[NSMutableArray alloc] initWithContentsOfFile:[self.filePath stringByAppendingString:@".plist"]];

        
    //otherwise, initialize an empty high scores array
    if (! self.highScoresArray) 
    {
        self.highScoresArray = [[NSMutableArray alloc] init];
    }
}

//saves the scores to the plist
- (void) saveScores
{
    [self.highScoresArray writeToFile: [self.filePath stringByAppendingString: @".plist"] atomically:YES];
}


//Depending on how high the score is, adds the high score to the high scores table, in the right position
- (BOOL) addHighScore: (int) score
{
    NSNumber *newScore = [[NSNumber alloc] init];
    newScore = [NSNumber numberWithInt:score];

    //add score to the high scores array
    [self.highScoresArray addObject: newScore];

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

    NSLog(@"at the end of addHighScore, high scores are: %@", self.highScoresArray);
    return YES;
}

@end