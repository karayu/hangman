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
@property (strong, nonatomic) NSMutableArray *words;

//word length set by user
@property (nonatomic) int wordLength;
@property (nonatomic) int maxWordLength;
@property (nonatomic) int minWordLength;

//leters that the users have guessed
@property (nonatomic, strong) NSMutableArray *usedLetters;


- (int64_t) calculateScore;
- (BOOL) checkGameWon;
- (BOOL) setWordLength;
- (BOOL) setMaxWordLength;
- (BOOL) setMinWordLength;
- (void)loadDictionary;
- (NSString *) losingWord;
- (BOOL) letterValid: (NSString *) letter;

//the main brains behind everything
- (NSArray *) guessLetter: (NSString *) letter;

//set of words with letter in the right position(s)
- (NSMutableArray *) words: potentialWords WithLetter: (NSString *) letter InPosition: (NSString *) position;

//hash table mapping equivalence classes to words in that equivalence class
- (NSMutableDictionary *) words: (NSMutableArray *) words ByPositionForLetter: letter;
- (NSString *) occurenceLocations: (NSString *) letter InWord: (NSString *) string;
- (NSMutableArray *) words: words WithoutLetter: (NSString *)letter;



    


@end
