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

@property (nonatomic) int wordLength;
@property (nonatomic) int maxWordLength;
@property (nonatomic) int minWordLength;

@property (nonatomic) NSMutableArray *usedLetters;
- (NSArray *) guessLetter: (NSString *) letter;
- (int64_t) calculateScore;
- (BOOL) checkGameWon;
- (BOOL) setWordLength;
- (BOOL) setMaxWordLength;
- (BOOL) setMinWordLength;
- (void)loadDictionary;
- (BOOL) letterValid: (NSString *) letter;
- (NSArray *) guessLetter: (NSString *) letter; 
- (BOOL) checkGameWon;
- (int64_t) calculateScore;
- (NSMutableArray *) words: potentialWords WithLetter: (NSString *) letter InPosition: (NSString *) position;
- (NSMutableDictionary *) words: (NSMutableArray *) words ByPositionForLetter: letter;
- (NSString *) occurenceLocations: (NSString *) letter InWord: (NSString *) string;
- (NSMutableArray *) words: words WithoutLetter: (NSString *)letter;



    


@end
