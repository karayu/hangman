//
//  GoodGamePlay.h
//  project2
//
//  Created by Kara Yu on 4/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GamePlay.h"

@interface GoodGamePlay : GamePlay

//the word we are trying to guess
@property (nonatomic) NSString *word;

//the brains behind it all
- (NSArray *) guessLetter: (NSString *) letter;

//calculates the score, this is smaller for good game play
- (int) calculateScore;
- (BOOL) checkGameWon;
- (BOOL) pickWord;



@end
