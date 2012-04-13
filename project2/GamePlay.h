//
//  GamePlay.h
//  project2
//
//  Created by Kara Yu on 4/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GamePlay : NSObject

//dictionary of words
@property (strong, nonatomic) NSMutableArray *words;

@property (nonatomic) int maxWordLength;
@property (nonatomic) int minWordLength;
@property (nonatomic) int wordLength;

@property (nonatomic) NSMutableArray *usedLetters;

//high scores list

- (void) loadDictionary;
- (BOOL) setMaxWordLength;
- (BOOL) setMinWordLength;
- (BOOL)setWordLength;
- (BOOL) letterValid: (NSString *) letter;
- (NSString *) occurenceLocations: (NSString *) letter InWord: (NSString *) string;









@end
