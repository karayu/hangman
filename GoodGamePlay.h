//
//  GoodGamePlay.h
//  project2
//
//  Created by Kara Yu on 4/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoodGamePlay : NSObject

@property (nonatomic) NSString *word;
@property (strong, nonatomic) NSMutableArray *words;

@property (nonatomic) int maxWordLength;
@property (nonatomic) int minWordLength;

@property (nonatomic) int wordLength;

@property (nonatomic) NSMutableArray *usedLetters;

- (NSArray *) guessLetter: (NSString *) letter;
- (int64_t) calculateScore;
- (BOOL) checkGameWon;
- (NSArray *) guessLetter: (NSString *) letter;
- (NSString *) occurenceLocations: (NSString *) letter InWord: (NSString *) string;
- (BOOL) pickWord;
- (BOOL) setWordLength;
- (BOOL) setMaxWordLength;
- (BOOL) setMinWordLength;
- (void)loadDictionary;
- (BOOL) letterValid: (NSString *) letter;


@end
