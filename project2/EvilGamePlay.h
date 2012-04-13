//
//  WordList.h
//  project2
//
//  Created by Kara Yu on 3/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GamePlay.h"

@interface EvilGamePlay : GamePlay

//methods
- (int) calculateScore;
- (BOOL) checkGameWon;
- (NSArray *) guessLetter: (NSString *) letter;
- (NSString *) losingWord;

//hash table mapping equivalence classes to words in that equivalence class
- (NSMutableDictionary *) words: (NSMutableArray *) words ByPositionForLetter: letter;


@end
