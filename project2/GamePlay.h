//
//  GamePlay.h
//  project2
//
//  Created by Kara Yu on 4/12/12.
//  Copyright (c) 2012 EPIC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GamePlay : NSObject

extern NSString *FileName;

//dictionary of words
@property (strong, nonatomic) NSMutableArray *words;

//variables
@property (nonatomic) int maxWordLength;
@property (nonatomic) int minWordLength;
@property (nonatomic) int wordLength;
@property (nonatomic, strong) NSMutableArray *usedLetters;

//methods
- (void) loadDictionary;
- (BOOL) setMaxWordLength;
- (BOOL) setMinWordLength;
- (BOOL) setWordLength;
- (BOOL) letterValid: (NSString *) letter;
- (NSString *) occurenceLocations: (NSString *) letter InWord: (NSString *) string;









@end
