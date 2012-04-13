//
//  History.h
//  project2
//
//  Created by Kara Yu on 4/13/12.
//  Copyright (c) 2012 EPIC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface History : NSObject

//global constants
extern int MaxHighScores;
extern NSString *HighScoreFileName;

//variables
@property (nonatomic, strong) NSMutableArray *highScoresArray;

//methods
- (void)saveScores;
- (void)loadScores;
- (BOOL)addHighScore: (int)score;

@end


