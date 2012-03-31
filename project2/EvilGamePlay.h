//
//  WordList.h
//  project2
//
//  Created by Kara Yu on 3/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EvilGamePlay : NSObject

@property (strong, nonatomic) NSMutableDictionary *words;
@property (strong, nonatomic) NSMutableArray *potentialWords;

@property (nonatomic) BOOL *evil;
@property (nonatomic) int *remainingGuesses;
@property (nonatomic) int wordLength;
@property (nonatomic) int *totalGuesses;
@property (nonatomic) NSArray *usedLetters;


@end
