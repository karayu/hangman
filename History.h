//
//  History.h
//  project2
//
//  Created by Kara Yu on 4/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface History : NSObject

//global constants
extern int MaxHighScores;
extern NSString *HighScoreFileName;

@property (nonatomic, strong) NSMutableArray *highScoresArray;
- (BOOL) addHighScore: (int) score;


@end


