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

@property (nonatomic) NSString *word;
@property (strong, nonatomic) NSMutableArray *words;

@property (nonatomic) int maxWordLength;
@property (nonatomic) int minWordLength;
@property (nonatomic) int wordLength;

@property (nonatomic, readwrite) int maxHighScores;

@property (nonatomic) NSMutableArray *usedLetters;

//high scores list
@property (nonatomic, strong) NSMutableArray *highScores;

- (NSArray *) guessLetter: (NSString *) letter;
- (int) calculateScore;
- (BOOL) checkGameWon;
- (BOOL) letterValid: (NSString *) letter;
- (NSString *) occurenceLocations: (NSString *) letter InWord: (NSString *) string;
- (BOOL) pickWord;
- (BOOL) setWordLength;
- (BOOL) setMaxWordLength;
- (BOOL) setMinWordLength;
- (void)loadDictionary;




@end
