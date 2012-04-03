//
//  WordList.h
//  project2
//
//  Created by Kara Yu on 3/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EvilGamePlay : NSObject

@property (strong, nonatomic) NSMutableArray *words;
@property (strong, nonatomic) NSMutableArray *potentialWords;

@property (nonatomic) int *remainingGuesses;
@property (nonatomic) int wordLength;
@property (nonatomic) int maxWordLength;

@property (nonatomic) NSMutableArray *usedLetters;
- (int) guessLetter: (NSString *) letter;
- (int64_t) calculateScore;
- (BOOL) checkGameWon;


@end
