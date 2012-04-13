//
//  WordList.h
//  project2
//
//  Created by Kara Yu on 3/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EvilGamePlay : NSObject

//full list of words currently in play
@property (nonatomic, readwrite, strong) NSMutableArray *words;

//word length set by user
@property (nonatomic, readwrite) int wordLength;
@property (nonatomic, readwrite) int maxWordLength;
@property (nonatomic, readwrite) int minWordLength;

//leters that the users have guessed

//letters that the users have guessed
@property (nonatomic, strong) NSMutableArray *usedLetters;

//high scores list
@property (nonatomic, strong) NSMutableArray *highScores;


- (int) calculateScore;
- (BOOL) checkGameWon;
- (BOOL) setWordLength;
- (BOOL) setMaxWordLength;
- (BOOL) setMinWordLength;
- (void)loadDictionary;
- (NSString *) losingWord;
- (BOOL) letterValid: (NSString *) letter;
- (BOOL) addHighScore: (float) score;

//the main brains behind everything
- (NSArray *) guessLetter: (NSString *) letter;

//set of words with letter in the right position(s)
- (NSMutableArray *) words: potentialWords WithLetter: (NSString *) letter InPosition: (NSString *) position;

//hash table mapping equivalence classes to words in that equivalence class
- (NSMutableDictionary *) words: (NSMutableArray *) words ByPositionForLetter: letter;
- (NSString *) occurenceLocations: (NSString *) letter InWord: (NSString *) string;
- (NSMutableArray *) words: words WithoutLetter: (NSString *)letter;




@end
